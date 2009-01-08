From: Yoann Padioleau <padator@wanadoo.fr>
Subject: Re: source code transform
Date: Thu, 08 Jan 2009 17:45:01 -0600
Message-ID: <87skntqs5e.fsf@aryx.cs.uiuc.edu>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
	<1231354996.3545.80.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from expredir4.cites.uiuc.edu ([128.174.5.187]:65032 "EHLO
	expredir4.cites.uiuc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbZAIADX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 19:03:23 -0500
In-Reply-To: <1231354996.3545.80.camel@johannes> (Johannes Berg's message of "Wed\, 07 Jan 2009 20\:03\:16 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: mosfet <forumer@smartmobili.com>, linux-sparse@vger.kernel.org, Julia Lawall <julia@diku.dk>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2009-01-07 at 19:48 +0100, mosfet wrote:
>
>> I would like to know if sparse would be able to parse GCC source file to
>> add a comment in each function it encounters ?
>> For instance let's say I want to trace every function in c-parser.c :
>> 
>> 
>> static struct c_typespec
>> c_parser_enum_specifier (c_parser *parser)
>> {
>> ...
>> 
>> }
>> 
>> in a first step I would like to modify source code like this :
>> 
>> static struct c_typespec
>> c_parser_enum_specifier (c_parser *parser)
>> {
>>  fprintf(stderr, "c-parser.c: c_parser_enum_specifier()\n");
>> ...
>> 
>> }
>> 
>> is it possible with sparse ?
>
> Not sure, but spatch might be able to:
>
> http://www.emn.fr/x-info/coccinelle/

Yes it can. Just write this semantic patch: 

@@
identifier f;
@@

 f(...)
 { 
+ fprintf(stderr, "%s: %s()\n", __FILE__, __FUNCTION__);
 ...
 }


into a file such as instrument_tracing.cocci and then run spatch with 


 $ ./spatch -c instrument_tracing.cocci c-parser.c -o c-parser-instrumented.c



>
> johannes
