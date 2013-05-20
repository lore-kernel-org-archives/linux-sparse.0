From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Mon, 20 May 2013 19:37:14 +0100
Message-ID: <519A6D5A.8030808@ramsay1.demon.co.uk>
References: <5195370B.9080702@ramsay1.demon.co.uk> <51972FDB.6060201@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:50988 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756068Ab3ETSof (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 May 2013 14:44:35 -0400
In-Reply-To: <51972FDB.6060201@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On 05/16/2013 12:44 PM, Ramsay Jones wrote:
> 
>> diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
>> new file mode 100644
>> index 0000000..7427702
>> --- /dev/null
>> +++ b/validation/init-char-array1.c
>> @@ -0,0 +1,25 @@
>> +/*
>> + * for array of char, ("...") as the initializer is an gcc language
>> + * extension. check that a parenthesized string initializer is handled
>> + * correctly and that -Wparen-string warns about it's use.
>> + */
>> +static const char u[] = ("hello");
>> +static const char v[] = {"hello"};
>> +static const char w[] = "hello";
>> +static const char x[5] = "hello";
> 
> That seems not complete. I haven't found the official gcc rules
> about parenthesized string. I just try the following forms and
> gcc takes it.
> 
> char x1[] = { ("hello") };
> char x2[] = { (("hello")) };
> 
> I guess the rules is that parenthesized string can appear in
> any place where string was allowed.

Until i18n work started on git, I didn't know this was a gcc
extension at all! ;-) I looked at the gcc documentation available
to me at the time, and could not find it mentioned at all, let
alone as a gcc language extension. However, if it wasn't for the
-Wparen-string sparse warning, I wouldn't have suspected that
sparse was supposed to support it.

Also, I was slightly surprised that MSVC supported this syntax.
So, I looked at fixing sparse and came up with my patch. I then
found that tcc didn't support this syntax, which is not standard
C after all, so I submitted a patch to fix the git gettext 'N_'
macro which was the cause of the problem.

ATB,
Ramsay Jones



