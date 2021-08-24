import { app, BrowserWindow ,ipcMain,shell,Menu } from 'electron'
const fs = require('fs')
const os = require('os')
const path = require('path')
import '../renderer/store'

/**
 * Set `__static` path to static files in production
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-static-assets.html
 */
if (process.env.NODE_ENV !== 'development') {
  global.__static = require('path').join(__dirname, '/static').replace(/\\/g, '\\\\')
}

let mainWindow
let pdfWin
const winURL = process.env.NODE_ENV === 'development'
  ? `http://localhost:9080`
  : `file://${__dirname}/index.html`

function createWindow () {
  /**
   * Initial window options
   */
  mainWindow = new BrowserWindow({
    height: 700,
    useContentSize: true,
    width: 1000,
    frame:false,
    backgroundColor: '#00000000',
    webPreferences: {
      nodeIntegration: true,
      webSecurity: false
   }
  })
  mainWindow.webContents.closeDevTools()
  mainWindow.loadURL(winURL)
  mainWindow.on('closed', () => {
    mainWindow = null
  })



}



app.on('ready',  () => {
  setTimeout(() => {
  createWindow() //解决Linux下背景无法透明问题
  mainWindow.setMinimumSize(950,665)
  mainWindow.setMaximumSize(1600,1120)

},0)

  })  

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (mainWindow === null) {
    createWindow()
  }
})

ipcMain.on('print-to-pdf', function (event) {
  const pdfPath = 'print.pdf'
  const win = BrowserWindow.fromWebContents(event.sender)
  // 使用默认打印选项
  win.webContents.printToPDF({
    pageSize:'A4',
    printBackground: true
  }, function (error, data) {
    if (error) throw error
    fs.writeFile(pdfPath, data, function (error) {
      if (error) {
        throw error
      }
      shell.openExternal(pdfPath)
    })
  })
  event.sender.send('reply', 'success')
})

ipcMain.on('createPDF',function(event,plan){
 pdfWin=new BrowserWindow({
    title:'计划清单',
    height: 600,
    useContentSize: true,
    width: 600,
    webPreferences: {
      nodeIntegration: true,
   }
  })
  pdfWin.webContents.closeDevTools()
  pdfWin.on('closed', () => {
    pdfWin= null
  })
  Menu.setApplicationMenu(null)
  pdfWin.loadURL(winURL+'#/pdf')
  pdfWin.webContents.on('did-finish-load',function(){
    pdfWin.webContents.send('plan', plan)
  })
})



/**
 * Auto Updater
 *
 * Uncomment the following code below and install `electron-updater` to
 * support auto updating. Code Signing with a valid certificate is required.
 * https://simulatedgreg.gitbooks.io/electron-vue/content/en/using-electron-builder.html#auto-updating
 */

/*
import { autoUpdater } from 'electron-updater'

autoUpdater.on('update-downloaded', () => {
  autoUpdater.quitAndInstall()
})

app.on('ready', () => {
  if (process.env.NODE_ENV === 'production') autoUpdater.checkForUpdates()
})
 */
