
find_package(Qt5Gui REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Quick REQUIRED)

configure_file(qmldir.in Ergo/qmldir)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_library(${PLUGIN_NAME} SHARED
  plugin.cpp

  clipboard.cpp
  clipboard.h
  gettext.cpp
  gettext.h
  units.cpp
  units.h
  unitythemeiconprovider.cpp
  unitythemeiconprovider.h
)

set_target_properties(${PLUGIN_NAME} PROPERTIES
  LIBRARY_OUTPUT_DIRECTORY Ergo
)

target_link_libraries(${PLUGIN_NAME}
  Qt5::Core
  Qt5::Gui
  Qt5::Qml
  Qt5::Quick

  ${Intl_LIBRARIES}
  ${CMAKE_THREAD_LIBS_INIT}
)

# Install the plugin and components
set(PLUGIN_INSTALL_LIBDIR "${CMAKE_INSTALL_LIBDIR}/qt5/qml/Ergo")
if(CLICK_MODE)
  set(PLUGIN_INSTALL_LIBDIR "${CMAKE_INSTALL_LIBDIR}/Ergo")
endif(CLICK_MODE)
install(TARGETS ${PLUGIN_NAME}
  DESTINATION ${PLUGIN_INSTALL_LIBDIR}
)
# FIXME: Need to install these pieces in a better way
file(GLOB QML_FILES "Ergo/*.qml" "Ergo/*.js")
install(FILES ${QML_FILES} ${CMAKE_CURRENT_BINARY_DIR}/Ergo/qmldir
  DESTINATION ${PLUGIN_INSTALL_LIBDIR}
)

# We need tests
add_subdirectory(tests)

set(COVERAGE_TEST_TARGETS
  ${COVERAGE_TEST_TARGETS}
  PARENT_SCOPE
)

add_test(
  NAME qmllint
  COMMAND qmllint ${QML_FILES}
)
