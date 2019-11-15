# Install the style. This must currently be installed under QQC2's directory
set(STYLE_INSTALL_LIBDIR "${CMAKE_INSTALL_LIBDIR}/qt5/qml/QtQuick/Controls.2/Ergo")
if(CLICK_MODE)
  set(STYLE_INSTALL_LIBDIR "${CMAKE_INSTALL_LIBDIR}/QtQuick/Controls.2/Ergo")
endif(CLICK_MODE)
# FIXME: Need to install these pieces in a better way
file(GLOB QML_FILES "*.qml" "*.js")
install(FILES ${QML_FILES}
  DESTINATION ${STYLE_INSTALL_LIBDIR}
)

add_test(
  NAME qmllint-style
  COMMAND qmllint ${QML_FILES}
)
