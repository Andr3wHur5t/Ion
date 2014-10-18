//
//  PHText.m
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "PHText.h"
#import "NSArray+PHGetters.h"

static NSUInteger sPHMinIdealSentenceWordCount = 6;
static NSUInteger sPHMaxIdealSentenceWordCount = 24;
static NSUInteger sPHMinIdealParagraphSentenceCount = 4;
static NSUInteger sPHMaxIdealParagraphSentenceCount = 8;
static NSUInteger sPHRecentWordsCount = 4;

@implementation PHText
#pragma mark Generators
+ (NSString *)loremWithWordCount:(NSUInteger) wordCount {
    NSArray *sentenceLengths, *paragraphLengths, *sentences;
    
    // Get our Lengths
    sentenceLengths = [NSArray generateLengthsArrayWithIdealMin: sPHMinIdealSentenceWordCount
                                                       idealMax: sPHMaxIdealSentenceWordCount
                                                        andGoal: wordCount];
    paragraphLengths = [NSArray generateLengthsArrayWithIdealMin: sPHMinIdealParagraphSentenceCount
                                                        idealMax: sPHMaxIdealParagraphSentenceCount
                                                         andGoal: sentenceLengths.count];
    
    // Generate raw sentences
    sentences = [[self class] generateLoremSentencesWithSentenceLengths: sentenceLengths];
    
    if ( wordCount <= sPHMinIdealSentenceWordCount )
        return [sentences objectAtIndex: 0];
    else
        // Composite sentences into paragraphs and return
        return [[self class] generateParagraphStringFromSentences: sentences
                                              andParagraphLengths: paragraphLengths];
}

+ (NSArray *)generateLoremSentencesWithSentenceLengths:(NSArray *)sentenceLengths {
    NSMutableArray *sentences, *recentWords;
    NSString *currentString, *currentWord;
    BOOL checkRecentWords, wordFailed;
    
    NSParameterAssert( sentenceLengths && [sentenceLengths isKindOfClass: [NSArray class]] );
    if ( !sentenceLengths || ![sentenceLengths isKindOfClass:[NSArray class]] )
        return NULL;
    
    // Setup
    currentString = @"";
    currentWord = @"";
    recentWords = [[NSMutableArray alloc] init];
    sentences = [[NSMutableArray alloc] init];
    
    // Go through all sentence lengths, and generate a sentence for it.
    for ( NSNumber *length in sentenceLengths) {
        
        // Setup for sentence generation
        [recentWords removeAllObjects];
        currentString = @"";
        
        // Generate a word for each length
        for ( NSUInteger i = 0; i < [length unsignedIntegerValue]; ++i ) {
            checkRecentWords = TRUE;
            
            // Get the next word.
            currentWord = [[[self class] loremIpsumWords] randomObject];
            
            // Make sure the word hasn't been recently used
            while ( checkRecentWords ) {
                wordFailed = FALSE;
                
                // Go through our recent words and compare
                for ( NSString* word in recentWords )
                    if ( [word isEqualToString: currentWord] )
                        wordFailed = TRUE; // Our word was recently used, get a new one
                
                // Check if the word failed
                if ( wordFailed )
                    currentWord = [[[self class] loremIpsumWords] randomObject]; // try again
                else
                    checkRecentWords = FALSE; // We have a good word, continue.
            }
            
            // Update our recent words
            if ( recentWords.count >= sPHRecentWordsCount)
                [recentWords removeObject: [recentWords firstObject]]; // Remove if we hit our limmit.
            [recentWords addObject: currentWord];
            
            // Capitalize first word
            if ( i == 0 )
                currentWord = [currentWord capitalizedString];
            
            
            // Add the next word to the sentence with the apropreate spaceing.
            currentString = [NSString stringWithFormat: @"%@%@%@",
                             currentString,
                             currentString.length == 0 ? @"" : @" ",
                             currentWord];
            
            
        }
        
        // Add the current sentence.
        [sentences addObject: currentString];
    }
    return sentences;
}

+ (NSString *)generateParagraphStringFromSentences:(NSArray *)sentences
                               andParagraphLengths:(NSArray *)paragraphLengths {
    NSString *resultString, *currentSentence;
    NSParameterAssert( sentences && [sentences isKindOfClass: [NSArray class]] );
    NSParameterAssert( paragraphLengths && [paragraphLengths isKindOfClass: [NSArray class]] );
    if ( !sentences || ![sentences isKindOfClass: [NSArray class]] ||
        !paragraphLengths || ![paragraphLengths isKindOfClass: [NSArray class]] )
        return NULL;
    
    // Setup
    resultString = @"";
    
    // Composite Paragraphs
    for ( NSNumber *length in paragraphLengths ) {
        
        // Add the sentences to the string
        for ( NSUInteger i = 0; i < [length unsignedIntegerValue]; ++i ) {
            
            // Get the next sentence, append it to our return string, and add punctuation.
            currentSentence = [sentences objectAtIndex: i];
            if ( [currentSentence isKindOfClass: [NSString class]] )
                resultString = [NSString stringWithFormat: @"%@%@%@", resultString, currentSentence,  @". "];
            
        }
        
        // Add some nice new lines
        resultString = [resultString stringByAppendingString: @"\n\n"];
    }
    return resultString;
}


#pragma mark Data

+ (NSArray *)loremIpsumWords {
    static NSArray *_loremIpsumWords;
    static dispatch_once_t _loremIpsumWords_oncetoken;
    
    dispatch_once( &_loremIpsumWords_oncetoken, ^{
        _loremIpsumWords =  [@"lorem,ipsum,dolor,sit,amet,consectetuer,adipiscing,elit,integer,in,mi,a,mauris,"\
            @"ornare,sagittis,suspendisse,potenti,suspendisse,dapibus,dignissim,dolor,nam,"\
            @"sapien,tellus,tempus,et,tempus,ac,tincidunt,in,arcu,duis,dictum,proin,magna,"\
            @"nulla,pellentesque,non,commodo,et,iaculis,sit,amet,mi,mauris,condimentum,massa,"\
            @"ut,metus,donec,viverra,sapien,mattis,rutrum,tristique,lacus,eros,semper,tellus,"\
            @"et,molestie,nisi,sapien,eu,massa,vestibulum,ante,ipsum,primis,in,faucibus,orci,"\
            @"luctus,et,ultrices,posuere,cubilia,curae,fusce,erat,tortor,mollis,ut,accumsan,"\
            @"ut,lacinia,gravida,libero,curabitur,massa,felis,accumsan,feugiat,convallis,sit,"\
            @"amet,porta,vel,neque,duis,et,ligula,non,elit,ultricies,rutrum,suspendisse,"\
            @"tempor,quisque,posuere,malesuada,velit,sed,pellentesque,mi,a,purus,integer,"\
            @"imperdiet,orci,a,eleifend,mollis,velit,nulla,iaculis,arcu,eu,rutrum,magna,quam,"\
            @"sed,elit,nullam,egestas,integer,interdum,purus,nec,mauris,vestibulum,ac,mi,in,"\
            @"nunc,suscipit,dapibus,duis,consectetuer,ipsum,et,pharetra,sollicitudin,metus,"\
            @"turpis,facilisis,magna,vitae,dictum,ligula,nulla,nec,mi,nunc,ante,urna,gravida,"\
            @"sit,amet,congue,et,accumsan,vitae,magna,praesent,luctus,nullam,in,velit,"\
            @"praesent,est,curabitur,turpis,class,aptent,taciti,sociosqu,ad,litora,torquent,"\
            @"per,conubia,nostra,per,inceptos,hymenaeos,cras,consectetuer,nibh,in,lacinia,"\
            @"ornare,turpis,sem,tempor,massa,sagittis,feugiat,mauris,nibh,non,tellus,"\
            @"phasellus,mi,fusce,enim,mauris,ultrices,turpis,eu,adipiscing,viverra,justo,"\
            @"libero,ullamcorper,massa,id,ultrices,velit,est,quis,tortor,quisque,condimentum,"\
            @"lacus,volutpat,nonummy,accumsan,est,nunc,imperdiet,magna,vulputate,aliquet,nisi,"\
            @"risus,at,est,aliquam,imperdiet,gravida,tortor,praesent,interdum,accumsan,ante,"\
            @"vivamus,est,ligula,consequat,sed,pulvinar,eu,consequat,vitae,eros,nulla,elit,"\
            @"nunc,congue,eget,scelerisque,a,tempor,ac,nisi,morbi,facilisis,pellentesque,"\
            @"habitant,morbi,tristique,senectus,et,netus,et,malesuada,fames,ac,turpis,egestas,"\
            @"in,hac,habitasse,platea,dictumst,suspendisse,vel,lorem,ut,ligula,tempor,"\
            @"consequat,quisque,consectetuer,nisl,eget,elit,proin,quis,mauris,ac,orci,"\
            @"accumsan,suscipit,sed,ipsum,sed,vel,libero,nec,elit,feugiat,blandit,vestibulum,"\
            @"purus,nulla,accumsan,et,volutpat,at,pellentesque,vel,urna,suspendisse,nonummy,"\
            @"aliquam,pulvinar,libero,donec,vulputate,orci,ornare,bibendum,condimentum,lorem,"\
            @"elit,dignissim,sapien,ut,aliquam,nibh,augue,in,turpis,phasellus,ac,eros,"\
            @"praesent,luctus,lorem,a,mollis,lacinia,leo,turpis,commodo,sem,in,lacinia,mi,"\
            @"quam,et,quam,curabitur,a,libero,vel,tellus,mattis,imperdiet,in,congue,neque,ut,"\
            @"scelerisque,bibendum,libero,lacus,ullamcorper,sapien,quis,aliquet,massa,velit,"\
            @"vel,orci,fusce,in,nulla,quis,est,cursus,gravida,in,nibh,lorem,ipsum,dolor,sit,"\
            @"amet,consectetuer,adipiscing,elit,integer,fermentum,pretium,massa,morbi,feugiat,"\
            @"iaculis,nunc,aenean,aliquam,pretium,orci,cum,sociis,natoque,penatibus,et,magnis,"\
            @"dis,parturient,montes,nascetur,ridiculus,mus,vivamus,quis,tellus,vel,quam,"\
            @"varius,bibendum,fusce,est,metus,feugiat,at,porttitor,et,cursus,quis,pede,nam,ut,"\
            @"augue,nulla,posuere,phasellus,at,dolor,a,enim,cursus,vestibulum,duis,id,nisi,"\
            @"duis,semper,tellus,ac,nulla,vestibulum,scelerisque,lobortis,dolor,aenean,a,"\
            @"felis,aliquam,erat,volutpat,donec,a,magna,vitae,pede,sagittis,lacinia,cras,"\
            @"vestibulum,diam,ut,arcu,mauris,a,nunc,duis,sollicitudin,erat,sit,amet,turpis,"\
            @"proin,at,libero,eu,diam,lobortis,fermentum,nunc,lorem,turpis,imperdiet,id,"\
            @"gravida,eget,aliquet,sed,purus,ut,vehicula,laoreet,ante,mauris,eu,nunc,sed,sit,"\
            @"amet,elit,nec,ipsum,aliquam,egestas,donec,non,nibh,cras,sodales,pretium,massa,"\
            @"praesent,hendrerit,est,et,risus,vivamus,eget,pede,curabitur,tristique,"\
            @"scelerisque,dui,nullam,ullamcorper,vivamus,venenatis,velit,eget,enim,nunc,eu,"\
            @"nunc,eget,felis,malesuada,fermentum,quisque,magna,mauris,ligula,felis,luctus,a,"\
            @"aliquet,nec,vulputate,eget,magna,quisque,placerat,diam,sed,arcu,praesent,"\
            @"sollicitudin,aliquam,non,sapien,quisque,id,augue,class,aptent,taciti,sociosqu,"\
            @"ad,litora,torquent,per,conubia,nostra,per,inceptos,hymenaeos,etiam,lacus,lectus,"\
            @"mollis,quis,mattis,nec,commodo,facilisis,nibh,sed,sodales,sapien,ac,ante,duis,"\
            @"eget,lectus,in,nibh,lacinia,auctor,fusce,interdum,lectus,non,dui,integer,"\
            @"accumsan,quisque,quam,curabitur,scelerisque,imperdiet,nisl,suspendisse,potenti,"\
            @"nam,massa,leo,iaculis,sed,accumsan,id,ultrices,nec,velit,suspendisse,potenti,"\
            @"mauris,bibendum,turpis,ac,viverra,sollicitudin,metus,massa,interdum,orci,non,"\
            @"imperdiet,orci,ante,at,ipsum,etiam,eget,magna,mauris,at,tortor,eu,lectus,"\
            @"tempor,tincidunt,phasellus,justo,purus,pharetra,ut,ultricies,nec,consequat,vel,"\
            @"nisi,fusce,vitae,velit,at,libero,sollicitudin,sodales,aenean,mi,libero,ultrices,"\
            @"id,suscipit,vitae,dapibus,eu,metus,aenean,vestibulum,nibh,ac,massa,vivamus,"\
            @"vestibulum,libero,vitae,purus,in,hac,habitasse,platea,dictumst,curabitur,"\
            @"blandit,nunc,non,arcu,ut,nec,nibh,morbi,quis,leo,vel,magna,commodo,rhoncus,"\
            @"donec,congue,leo,eu,lacus,pellentesque,at,erat,id,mi,consequat,congue,praesent,"\
            @"a,nisl,ut,diam,interdum,molestie,fusce,suscipit,rhoncus,sem,donec,pretium,"\
            @"aliquam,molestie,vivamus,et,justo,at,augue,aliquet,dapibus,pellentesque,felis,"\
            @"morbi,semper,in,venenatis,imperdiet,neque,donec,auctor,molestie,augue,nulla,id,"\
            @"arcu,sit,amet,dui,lacinia,convallis,proin,tincidunt,proin,a,ante,nunc,imperdiet,"\
            @"augue,nullam,sit,amet,arcu,quisque,laoreet,viverra,felis,lorem,ipsum,dolor,sit,"\
            @"amet,consectetuer,adipiscing,elit,in,hac,habitasse,platea,dictumst,pellentesque,"\
            @"habitant,morbi,tristique,senectus,et,netus,et,malesuada,fames,ac,turpis,egestas,"\
            @"class,aptent,taciti,sociosqu,ad,litora,torquent,per,conubia,nostra,per,inceptos,"\
            @"hymenaeos,nullam,nibh,sapien,volutpat,ut,placerat,quis,ornare,at,lorem,class,"\
            @"aptent,taciti,sociosqu,ad,litora,torquent,per,conubia,nostra,per,inceptos,"\
            @"hymenaeos,morbi,dictum,massa,id,libero,ut,neque,phasellus,tincidunt,nibh,ut,"\
            @"tincidunt,lacinia,lacus,nulla,aliquam,mi,a,interdum,dui,augue,non,pede,duis,"\
            @"nunc,magna,vulputate,a,porta,at,tincidunt,a,nulla,praesent,facilisis,"\
            @"suspendisse,sodales,feugiat,purus,cras,et,justo,a,mauris,mollis,imperdiet,morbi,"\
            @"erat,mi,ultrices,eget,aliquam,elementum,iaculis,id,velit,in,scelerisque,enim,"\
            @"sit,amet,turpis,sed,aliquam,odio,nonummy,ullamcorper,mollis,lacus,nibh,tempor,"\
            @"dolor,sit,amet,varius,sem,neque,ac,dui,nunc,et,est,eu,massa,eleifend,mollis,"\
            @"mauris,aliquet,orci,quis,tellus,ut,mattis,praesent,mollis,consectetuer,quam,"\
            @"nulla,nulla,nunc,accumsan,nunc,sit,amet,scelerisque,porttitor,nibh,pede,lacinia,"\
            @"justo,tristique,mattis,purus,eros,non,velit,aenean,sagittis,commodo,erat,"\
            @"aliquam,id,lacus,morbi,vulputate,vestibulum,elit" componentsSeparatedByString:@","];
    });
    return _loremIpsumWords;
}

@end
