From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3 V3] Add Wall_off switch to disable errors and warnings
Date: Sat, 1 Aug 2015 09:52:48 -0400
Message-ID: <55BCCF30.3040409@redhat.com>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <1438370879-21792-1-git-send-email-tcamuso@redhat.com>
 <20150801125938.GA23735@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbbHANwu (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 09:52:50 -0400
In-Reply-To: <20150801125938.GA23735@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On 08/01/2015 08:59 AM, Sam Ravnborg wrote:
>> diff --git a/parse.c b/parse.c
>> index 02275d8..d70dffb 100644
>> --- a/parse.c
>> +++ b/parse.c
>> @@ -2746,6 +2746,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>>
>>   	/* Just a type declaration? */
>>   	if (!ident) {
>> +
>> +		if (Wall_off)
>> +			return token->next;
>> +
>>   		warning(token->pos, "missing identifier in declaration");
>>   		return expect(token, ';', "at the end of type declaration");
>
> This is on the wrong level.
> You need to silence sparse in the spare_error function.
>
> Not on the level where you do the expect() - otherwise you would
> have to sprinkle "if (Wall_off)" checks everywhere.
>
> This was also a problem in v1 of the patch.
>
> 	Sam
>

Thanks, Sam. Rework in progress ...

