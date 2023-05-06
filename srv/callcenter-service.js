const cds = require('@sap/cds')

module.exports = function () {
    const { Inquiries } = cds.entities 

    this.after('READ', 'Inquiries', (each) => {
        //for new inquires only
        if (each.status_code === '1' ) { 
            each.startEnabled = true
        }
        //for active inquires only
        if (each.status_code !== '3') {
            each.closeEnabled = true
        }
    })   

    this.on ('start', async (req)=> {
        return req.error(404, 'Error message')
        // const id = req.params[0]
        // const n = await UPDATE(Inquiries).set({ 
        //     status_code:'2',
        //     startedAt: Date.now()
        // }).where ({ID:id}).and({status_code:'1'})
        // n > 0 || req.error (404) 
    })

    this.on('close', async (req) => {
        const id = req.params[0]
        const { satisfaction } = req.data
        const n = await UPDATE(Inquiries).set({ 
            satisfaction: satisfaction,
            status_code: '3'
        }).where ({ID:id}).and({status_code:{'<>':'3'}})
        n > 0 || req.error (404)        
    })
    
    this.before('CREATE', Inquiries, (req) => {
        req.status_code = '1'
    })
}
 
