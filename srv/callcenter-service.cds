using { demo.callcenter as call } from '../db/schema';

service CallCenterService {
    entity Inquiries as projection on call.Inquiries
    actions {
        @sap.applicable.path: 'startEnabled'
        action start();
        @sap.applicable.path: 'closeEnabled'
        action close(satisfaction: Integer);
    }   
}

annotate CallCenterService.Inquiries with @(
    UI: {
        SelectionFields  : [
            category_code,
            status_code,
            satisfaction
        ],
        LineItem  : [
            { $Type: 'UI.DataFieldForAction', Action: 'CallCenterService.EntityContainer/Inquiries_start', Label: 'Start'},
            { $Type: 'UI.DataFieldForAction', Action: 'CallCenterService.EntityContainer/Inquiries_close', Label: 'Close'},
            { Value: category_code },
            { Value: inquiry },
            { Value: status_code },
            { Value: startedAt },
            { Value: satisfaction },
            { Value: createdAt },
            { Value: modifiedAt }            
        ],
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#Inquirey',
            }
        ],
        FieldGroup #Inquirey : {
            $Type : 'UI.FieldGroupType',
            Label : 'Inquirey Data',
            Data : [
                { Value: category_code },
                { Value: inquiry },
                { Value: answer }
            ],
            
        },
    }
);