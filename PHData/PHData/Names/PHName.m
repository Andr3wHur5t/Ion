//
//  PHName.m
//  PHData
//
//  Created by Andrew Hurst on 10/7/14.
//  Copyright (c) 2014 Andrew Hurst. All rights reserved.
//

#import "PHName.h"
#import "NSArray+PHGetters.h"

@interface PHName ()

/**
 * An array of common feminine first names.
 */
+ (NSArray *)feminineFirstNamesArray;

/**
 * An array of common masculine first names.
 */
+ (NSArray *)masculineFirstNameArray;

/**
 * An array of common first names.
 */
+ (NSArray *)firstNameArray;

/**
 * An array of common last names.
 */
+ (NSArray *)lastNameArray;

/**
 * Generates a formated name using the inputted values.
 * @param firstName - the first name.
 * @param middleName - the full middle name.
 * @param lastName - the last name.
 * @param options - the options to use in compositing the string.
 */
+ (NSString *)nameStringUsingFirstName:(NSString *)firstName
                            middleName:(NSString *)middleName
                              lastName:(NSString *)lastName
                          usingOptions:(NSUInteger) options;
@end

@implementation PHName
#pragma mark Name Generation

+ (NSString *)randomName {
    return [[self class] randomNameWithOptions: sPHNameDefaultGenerationOptions];
}

+ (NSString *)randomMasculineName {
    return [[self class] randomMasculineNameWithOptions: sPHNameDefaultGenerationOptions];
}

+ (NSString *)randomFeminineName {
    return [[self class] randomFeminineNameWithOptions: sPHNameDefaultGenerationOptions];
}

#pragma mark Name Generation

+ (NSString *)randomMasculineNameWithOptions:(NSUInteger) options {
    return [[self class] nameStringUsingFirstName: [[self class] randomMasculineFirstName]
                                       middleName: [[self class] randomFirstName]
                                         lastName: [[self class] randomLastName]
                                     usingOptions: options];
}

+ (NSString *)randomFeminineNameWithOptions:(NSUInteger) options {
    return [[self class] nameStringUsingFirstName: [[self class] randomFeminineFirstName]
                                       middleName: [[self class] randomFirstName]
                                         lastName: [[self class] randomLastName]
                                     usingOptions: options];
}

+ (NSString *)randomNameWithOptions:(NSUInteger) options {
    return  [[self class] nameStringUsingFirstName: [[self class] randomFirstName]
                                        middleName: [[self class] randomFirstName]
                                          lastName: [[self class] randomLastName]
                                      usingOptions: options];
}

+ (NSString *)nameStringUsingFirstName:(NSString *)firstName
                            middleName:(NSString *)middleName
                              lastName:(NSString *)lastName
                          usingOptions:(NSUInteger) options {
    NSString *_formatString, *_firstString, *_middleString, *_lastString;
//    BOOL usesMiddleName;
    
    _formatString = @"%@%@ %@";
    
    _firstString = firstName;
    _middleString = @"";
    _lastString = lastName;
    return [NSString stringWithFormat: _formatString, _firstString, _middleString, _lastString ];
}

#pragma mark Name Segment Getters

+ (NSString *)randomFeminineFirstName {
    return [[[self class] feminineFirstNamesArray] randomPrettyString];
}

+ (NSString *)randomMasculineFirstName {
    return [[[self class] masculineFirstNameArray] randomPrettyString];
}

+ (NSString *)randomFirstName {
    return [[[self class] firstNameArray] randomPrettyString];
}

+ (NSString *)randomLastName {
    return [[[self class] lastNameArray] randomPrettyString];
}

#pragma mark Name Data

+ (NSArray *)feminineFirstNamesArray {
    static NSArray *_feminineFirstNamesArray;
    static dispatch_once_t _feminineFirstNamesArray_onceToken;
    dispatch_once( &_feminineFirstNamesArray_onceToken, ^{
        _feminineFirstNamesArray = @[
             @"MARY",
             @"PATRICIA",
             @"LINDA",
             @"BARBARA",
             @"ELIZABETH",
             @"JENNIFER",
             @"MARIA",
             @"SUSAN",
             @"MARGARET",
             @"DOROTHY",
             @"LISA",
             @"NANCY",
             @"KAREN",
             @"BETTY",
             @"HELEN",
             @"SANDRA",
             @"DONNA",
             @"CAROL",
             @"RUTH",
             @"SHARON",
             @"MICHELLE",
             @"LAURA",
             @"SARAH",
             @"KIMBERLY",
             @"DEBORAH",
             @"JESSICA",
             @"SHIRLEY",
             @"CYNTHIA",
             @"ANGELA",
             @"MELISSA",
             @"BRENDA",
             @"AMY",
             @"ANNA",
             @"REBECCA",
             @"VIRGINIA",
             @"KATHLEEN",
             @"PAMELA",
             @"MARTHA",
             @"DEBRA",
             @"AMANDA",
             @"STEPHANIE",
             @"CAROLYN",
             @"CHRISTINE",
             @"MARIE",
             @"JANET",
             @"CATHERINE",
             @"FRANCES",
             @"ANN",
             @"JOYCE",
             @"DIANE",
             @"ALICE",
             @"JULIE",
             @"HEATHER",
             @"TERESA",
             @"DORIS",
             @"GLORIA",
             @"EVELYN",
             @"JEAN",
             @"CHERYL",
             @"MILDRED",
             @"KATHERINE",
             @"JOAN",
             @"ASHLEY",
             @"JUDITH",
             @"ROSE",
             @"JANICE",
             @"KELLY",
             @"NICOLE",
             @"JUDY",
             @"CHRISTINA",
             @"KATHY",
             @"THERESA",
             @"BEVERLY",
             @"DENISE",
             @"TAMMY",
             @"IRENE",
             @"JANE",
             @"LORI",
             @"RACHEL",
             @"MARILYN",
             @"ANDREA",
             @"KATHRYN",
             @"LOUISE",
             @"SARA",
             @"ANNE",
             @"JACQUELINE",
             @"WANDA",
             @"BONNIE",
             @"JULIA",
             @"RUBY",
             @"LOIS",
             @"TINA",
             @"PHYLLIS",
             @"NORMA",
             @"PAULA",
             @"DIANA",
             @"ANNIE",
             @"LILLIAN",
             @"EMILY",
             @"ROBIN",
             @"PEGGY",
             @"CRYSTAL",
             @"GLADYS",
             @"RITA",
             @"DAWN",
             @"CONNIE",
             @"FLORENCE",
             @"TRACY",
             @"EDNA",
             @"TIFFANY",
             @"CARMEN",
             @"ROSA",
             @"CINDY",
             @"GRACE",
             @"WENDY",
             @"VICTORIA",
             @"EDITH",
             @"KIM",
             @"SHERRY",
             @"SYLVIA",
             @"JOSEPHINE",
             @"THELMA",
             @"SHANNON",
             @"SHEILA",
             @"ETHEL",
             @"ELLEN",
             @"ELAINE",
             @"MARJORIE",
             @"CARRIE",
             @"CHARLOTTE",
             @"MONICA",
             @"ESTHER",
             @"PAULINE",
             @"EMMA",
             @"JUANITA",
             @"ANITA",
             @"RHONDA",
             @"HAZEL",
             @"AMBER",
             @"EVA",
             @"DEBBIE",
             @"APRIL",
             @"LESLIE",
             @"CLARA",
             @"LUCILLE",
             @"JAMIE",
             @"JOANNE",
             @"ELEANOR",
             @"VALERIE",
             @"DANIELLE",
             @"MEGAN",
             @"ALICIA",
             @"SUZANNE",
             @"MICHELE",
             @"GAIL",
             @"BERTHA",
             @"DARLENE",
             @"VERONICA",
             @"JILL",
             @"ERIN",
             @"GERALDINE",
             @"LAUREN",
             @"CATHY",
             @"JOANN",
             @"LORRAINE",
             @"LYNN",
             @"SALLY",
             @"REGINA",
             @"ERICA",
             @"BEATRICE",
             @"DOLORES",
             @"AUDREY",
             @"YVONNE",
             @"ANNETTE",
             @"JUNE",
             @"SAMANTHA",
             @"MARION",
             @"DANA",
             @"STACY",
             @"ANA",
             @"RENEE",
             @"IDA",
             @"VIVIAN",
             @"ROBERTA",
             @"HOLLY",
             @"BRITTANY",
             @"MELANIE",
             @"LORETTA",
             @"YOLANDA",
             @"JEANETTE",
             @"LAURIE",
             @"KATIE",
             @"KRISTEN",
             @"VANESSA",
             @"ALMA",
             @"SUE",
             @"ELSIE",
             @"BETH",
             @"JEANNE",
             @"VICKI",
             @"CARLA",
             @"TARA",
             @"ROSEMARY",
             @"EILEEN",
             @"TERRI",
             @"GERTRUDE",
             @"LUCY",
             @"TONYA",
             @"ELLA",
             @"STACEY",
             @"WILMA",
             @"GINA",
             @"KRISTIN",
             @"JESSIE",
             @"NATALIE",
             @"AGNES",
             @"VERA",
             @"WILLIE",
             @"CHARLENE",
             @"BESSIE",
             @"DELORES",
             @"MELINDA",
             @"PEARL",
             @"ARLENE",
             @"MAUREEN",
             @"COLLEEN",
             @"ALLISON",
             @"TAMARA",
             @"JOY",
             @"GEORGIA"
             ];
    });
    return _feminineFirstNamesArray;
}

+ (NSArray *)masculineFirstNameArray {
    static NSArray *_masculineFirstNameArray;
    static dispatch_once_t _masculineFirstNameArray_onceToken;
    dispatch_once( &_masculineFirstNameArray_onceToken, ^{
        _masculineFirstNameArray = @[
             @"JAMES",
             @"JOHN",
             @"ROBERT",
             @"MICHAEL",
             @"WILLIAM",
             @"DAVID",
             @"RICHARD",
             @"CHARLES",
             @"JOSEPH",
             @"THOMAS",
             @"CHRISTOPHER",
             @"DANIEL",
             @"PAUL",
             @"MARK",
             @"DONALD",
             @"GEORGE",
             @"KENNETH",
             @"STEVEN",
             @"EDWARD",
             @"BRIAN",
             @"RONALD",
             @"ANTHONY",
             @"KEVIN",
             @"JASON",
             @"MATTHEW",
             @"GARY",
             @"TIMOTHY",
             @"JOSE",
             @"LARRY",
             @"JEFFREY",
             @"FRANK",
             @"SCOTT",
             @"ERIC",
             @"STEPHEN",
             @"ANDREW",
             @"RAYMOND",
             @"GREGORY",
             @"JOSHUA",
             @"JERRY",
             @"DENNIS",
             @"WALTER",
             @"PATRICK",
             @"PETER",
             @"HAROLD",
             @"DOUGLAS",
             @"HENRY",
             @"CARL",
             @"ARTHUR",
             @"RYAN",
             @"ROGER",
             @"JOE",
             @"JUAN",
             @"JACK",
             @"ALBERT",
             @"JONATHAN",
             @"JUSTIN",
             @"TERRY",
             @"GERALD",
             @"KEITH",
             @"SAMUEL",
             @"WILLIE",
             @"RALPH",
             @"LAWRENCE",
             @"NICHOLAS",
             @"ROY",
             @"BENJAMIN",
             @"BRUCE",
             @"BRANDON",
             @"ADAM",
             @"HARRY",
             @"FRED",
             @"WAYNE",
             @"BILLY",
             @"STEVE",
             @"LOUIS",
             @"JEREMY",
             @"AARON",
             @"RANDY",
             @"HOWARD",
             @"EUGENE",
             @"CARLOS",
             @"RUSSELL",
             @"BOBBY",
             @"VICTOR",
             @"MARTIN",
             @"ERNEST",
             @"PHILLIP",
             @"TODD",
             @"JESSE",
             @"CRAIG",
             @"ALAN",
             @"SHAWN",
             @"CLARENCE",
             @"SEAN",
             @"PHILIP",
             @"CHRIS",
             @"JOHNNY",
             @"EARL",
             @"JIMMY",
             @"ANTONIO",
             @"DANNY",
             @"BRYAN",
             @"TONY",
             @"LUIS",
             @"MIKE",
             @"STANLEY",
             @"LEONARD",
             @"NATHAN",
             @"DALE",
             @"MANUEL",
             @"RODNEY",
             @"CURTIS",
             @"NORMAN",
             @"ALLEN",
             @"MARVIN",
             @"VINCENT",
             @"GLENN",
             @"JEFFERY",
             @"TRAVIS",
             @"JEFF",
             @"CHAD",
             @"JACOB",
             @"LEE",
             @"MELVIN",
             @"ALFRED",
             @"KYLE",
             @"FRANCIS",
             @"BRADLEY",
             @"JESUS",
             @"HERBERT",
             @"FREDERICK",
             @"RAY",
             @"JOEL",
             @"EDWIN",
             @"DON",
             @"EDDIE",
             @"RICKY",
             @"TROY",
             @"RANDALL",
             @"BARRY",
             @"ALEXANDER",
             @"BERNARD",
             @"MARIO",
             @"LEROY",
             @"FRANCISCO",
             @"MARCUS",
             @"MICHEAL",
             @"THEODORE",
             @"CLIFFORD",
             @"MIGUEL",
             @"OSCAR",
             @"JAY",
             @"JIM",
             @"TOM",
             @"CALVIN",
             @"ALEX",
             @"JON",
             @"RONNIE",
             @"BILL",
             @"LLOYD",
             @"TOMMY",
             @"LEON",
             @"DEREK",
             @"WARREN",
             @"DARRELL",
             @"JEROME",
             @"FLOYD",
             @"LEO",
             @"ALVIN",
             @"TIM",
             @"WESLEY",
             @"GORDON",
             @"DEAN",
             @"GREG",
             @"JORGE",
             @"DUSTIN",
             @"PEDRO",
             @"DERRICK",
             @"DAN",
             @"LEWIS",
             @"ZACHARY",
             @"COREY",
             @"HERMAN",
             @"MAURICE",
             @"VERNON",
             @"ROBERTO",
             @"CLYDE",
             @"GLEN",
             @"HECTOR",
             @"SHANE",
             @"RICARDO",
             @"SAM",
             @"RICK",
             @"LESTER",
             @"BRENT",
             @"RAMON",
             @"CHARLIE",
             @"TYLER",
             @"GILBERT",
             @"GENE",
             @"MARC",
             @"REGINALD",
             @"RUBEN",
             @"BRETT",
             @"ANGEL",
             @"NATHANIEL",
             @"RAFAEL",
             @"LESLIE",
             @"EDGAR",
             @"MILTON",
             @"RAUL",
             @"BEN",
             @"CHESTER",
             @"CECIL",
             @"DUANE",
             @"FRANKLIN",
             @"ANDRE",
             @"ELMER",
             @"BRAD",
             @"GABRIEL",
             @"RON",
             @"MITCHELL",
             @"ROLAND",
             @"ARNOLD",
             @"HARVEY",
             @"JARED",
             @"ADRIAN",
             @"KARL",
             @"CORY"
             ];
    });
    return _masculineFirstNameArray;
}

+ (NSArray *)firstNameArray {
    static NSArray *_firstNameArray;
    static dispatch_once_t _firstNameArray_onceToken;
    dispatch_once( &_firstNameArray_onceToken, ^{
        _firstNameArray = [[[self class] masculineFirstNameArray] arrayByAddingObjectsFromArray:
                                                            [[self class] feminineFirstNamesArray]];
    });
    return _firstNameArray;
}

+ (NSArray *)lastNameArray {
    static NSArray *_lastNameArray;
    static dispatch_once_t _lastNameArray_onceToken;
    dispatch_once( &_lastNameArray_onceToken, ^{
        _lastNameArray = @[
             @"SMITH",
             @"JOHNSON",
             @"WILLIAMS",
             @"JONES",
             @"BROWN",
             @"DAVIS",
             @"MILLER",
             @"WILSON",
             @"MOORE",
             @"TAYLOR",
             @"ANDERSON",
             @"THOMAS",
             @"JACKSON",
             @"WHITE",
             @"HARRIS",
             @"MARTIN",
             @"THOMPSON",
             @"GARCIA",
             @"MARTINEZ",
             @"ROBINSON",
             @"CLARK",
             @"RODRIGUEZ",
             @"LEWIS",
             @"LEE",
             @"WALKER",
             @"HALL",
             @"ALLEN",
             @"YOUNG",
             @"HERNANDEZ",
             @"KING",
             @"WRIGHT",
             @"LOPEZ",
             @"HILL",
             @"SCOTT",
             @"GREEN",
             @"ADAMS",
             @"BAKER",
             @"GONZALEZ",
             @"NELSON",
             @"CARTER",
             @"MITCHELL",
             @"PEREZ",
             @"ROBERTS",
             @"TURNER",
             @"PHILLIPS",
             @"CAMPBELL",
             @"PARKER",
             @"EVANS",
             @"EDWARDS",
             @"COLLINS",
             @"STEWART",
             @"SANCHEZ",
             @"MORRIS",
             @"ROGERS",
             @"REED",
             @"COOK",
             @"MORGAN",
             @"BELL",
             @"MURPHY",
             @"BAILEY",
             @"RIVERA",
             @"COOPER",
             @"RICHARDSON",
             @"COX",
             @"HOWARD",
             @"WARD",
             @"TORRES",
             @"PETERSON",
             @"GRAY",
             @"RAMIREZ",
             @"JAMES",
             @"WATSON",
             @"BROOKS",
             @"KELLY",
             @"SANDERS",
             @"PRICE",
             @"BENNETT",
             @"WOOD",
             @"BARNES",
             @"ROSS",
             @"HENDERSON",
             @"COLEMAN",
             @"JENKINS",
             @"PERRY",
             @"POWELL",
             @"LONG",
             @"PATTERSON",
             @"HUGHES",
             @"FLORES",
             @"WASHINGTON",
             @"BUTLER",
             @"SIMMONS",
             @"FOSTER",
             @"GONZALES",
             @"BRYANT",
             @"ALEXANDER",
             @"RUSSELL",
             @"GRIFFIN",
             @"DIAZ",
             @"HAYES",
             @"MYERS",
             @"FORD",
             @"HAMILTON",
             @"GRAHAM",
             @"SULLIVAN",
             @"WALLACE",
             @"WOODS",
             @"COLE",
             @"WEST",
             @"JORDAN",
             @"OWENS",
             @"REYNOLDS",
             @"FISHER",
             @"ELLIS",
             @"HARRISON",
             @"GIBSON",
             @"MCDONALD",
             @"CRUZ",
             @"MARSHALL",
             @"ORTIZ",
             @"GOMEZ",
             @"MURRAY",
             @"FREEMAN",
             @"WELLS",
             @"WEBB",
             @"SIMPSON",
             @"STEVENS",
             @"TUCKER",
             @"PORTER",
             @"HUNTER",
             @"HICKS",
             @"CRAWFORD",
             @"HENRY",
             @"BOYD",
             @"MASON",
             @"MORALES",
             @"KENNEDY",
             @"WARREN",
             @"DIXON",
             @"RAMOS",
             @"REYES",
             @"BURNS",
             @"GORDON",
             @"SHAW",
             @"HOLMES",
             @"RICE",
             @"ROBERTSON",
             @"HUNT",
             @"BLACK",
             @"DANIELS",
             @"PALMER",
             @"MILLS",
             @"NICHOLS",
             @"GRANT",
             @"KNIGHT",
             @"FERGUSON",
             @"ROSE",
             @"STONE",
             @"HAWKINS",
             @"DUNN",
             @"PERKINS",
             @"HUDSON",
             @"SPENCER",
             @"GARDNER",
             @"STEPHENS",
             @"PAYNE",
             @"PIERCE",
             @"BERRY",
             @"MATTHEWS",
             @"ARNOLD",
             @"WAGNER",
             @"WILLIS",
             @"RAY",
             @"WATKINS",
             @"OLSON",
             @"CARROLL",
             @"DUNCAN",
             @"SNYDER",
             @"HART",
             @"CUNNINGHAM",
             @"BRADLEY",
             @"LANE",
             @"ANDREWS",
             @"RUIZ",
             @"HARPER",
             @"FOX",
             @"RILEY",
             @"ARMSTRONG",
             @"CARPENTER",
             @"WEAVER",
             @"GREENE",
             @"LAWRENCE",
             @"ELLIOTT",
             @"CHAVEZ",
             @"SIMS",
             @"AUSTIN",
             @"PETERS",
             @"KELLEY",
             @"FRANKLIN",
             @"LAWSON",
             @"FIELDS",
             @"GUTIERREZ",
             @"RYAN",
             @"SCHMIDT",
             @"CARR",
             @"VASQUEZ",
             @"CASTILLO",
             @"WHEELER",
             @"CHAPMAN",
             @"OLIVER",
             @"MONTGOMERY",
             @"RICHARDS",
             @"WILLIAMSON",
             @"JOHNSTON",
             @"BANKS",
             @"MEYER",
             @"BISHOP"
             ];
    });
    return _lastNameArray;
}

@end
