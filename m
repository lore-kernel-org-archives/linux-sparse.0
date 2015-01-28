From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Wed, 28 Jan 2015 11:08:41 +0100
Message-ID: <54C8B529.4000805@de.ibm.com>
References: <54C15E0E.4000008@de.ibm.com> <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com> <20150123222332.GB42179@macpro.local> <20150123223856.GB1489@cloud> <20150123235934.GA42931@macpro.local> <54C54E3F.4000108@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:56460 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703AbbA1Ujf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Jan 2015 15:39:35 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 28 Jan 2015 10:08:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5B65F17D8067
	for <linux-sparse@vger.kernel.org>; Wed, 28 Jan 2015 10:08:48 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0SA8hLj55115790
	for <linux-sparse@vger.kernel.org>; Wed, 28 Jan 2015 10:08:43 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0SA8gjZ008172
	for <linux-sparse@vger.kernel.org>; Wed, 28 Jan 2015 03:08:43 -0700
In-Reply-To: <54C54E3F.4000108@de.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, josh@joshtriplett.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Am 25.01.2015 um 21:12 schrieb Christian Borntraeger:
> Am 24.01.2015 um 00:59 schrieb Luc Van Oostenryck:
> [...] 
>> Yes, indeed.
>> Thanks for bringing to my attention.
>>
>> Here is a new version of the patch taking care of that.
>>
>>
>> Luc
>>
>> ---
>> Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.
>>
>> This macro expands to sequential integral values starting from 0,
>> and this for each top-level source file.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

Christoper,
can you apply that fix as well?

Thans

> 
>> ---
>>  ident-list.h                       |  1 +
>>  pre-process.c                      |  4 ++++
>>  validation/preprocessor/counter1.c | 12 ++++++++++++
>>  validation/preprocessor/counter2.c | 14 ++++++++++++++
>>  validation/preprocessor/counter2.h |  1 +
>>  validation/preprocessor/counter3.c | 13 +++++++++++++
>>  6 files changed, 45 insertions(+)
>>  create mode 100644 validation/preprocessor/counter1.c
>>  create mode 100644 validation/preprocessor/counter2.c
>>  create mode 100644 validation/preprocessor/counter2.h
>>  create mode 100644 validation/preprocessor/counter3.c
>>
>> diff --git a/ident-list.h b/ident-list.h
>> index d5a145f8..b65b667d 100644
>> --- a/ident-list.h
>> +++ b/ident-list.h
>> @@ -108,6 +108,7 @@ __IDENT(__TIME___ident, "__TIME__", 0);
>>  __IDENT(__func___ident, "__func__", 0);
>>  __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
>>  __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
>> +__IDENT(__COUNTER___ident, "__COUNTER__", 0);
>>
>>  /* Sparse commands */
>>  IDENT_RESERVED(__context__);
>> diff --git a/pre-process.c b/pre-process.c
>> index 1aa3d2c4..601e0f26 100644
>> --- a/pre-process.c
>> +++ b/pre-process.c
>> @@ -45,6 +45,7 @@
>>  #include "scope.h"
>>
>>  static int false_nesting = 0;
>> +static int counter_macro;		// __COUNTER__ expansion
>>
>>  #define INCLUDEPATHS 300
>>  const char *includepath[INCLUDEPATHS+1] = {
>> @@ -181,6 +182,8 @@ static int expand_one_symbol(struct token **list)
>>  			time(&t);
>>  		strftime(buffer, 9, "%T", localtime(&t));
>>  		replace_with_string(token, buffer);
>> +	} else if (token->ident == &__COUNTER___ident) {
>> +		replace_with_integer(token, counter_macro++);
>>  	}
>>  	return 1;
>>  }
>> @@ -1882,6 +1885,7 @@ static void init_preprocessor(void)
>>  		sym->normal = 0;
>>  	}
>>
>> +	counter_macro = 0;
>>  }
>>
>>  static void handle_preprocessor_line(struct stream *stream, struct token **line, struct token *start)
>> diff --git a/validation/preprocessor/counter1.c b/validation/preprocessor/counter1.c
>> new file mode 100644
>> index 00000000..98187ee6
>> --- /dev/null
>> +++ b/validation/preprocessor/counter1.c
>> @@ -0,0 +1,12 @@
>> +__COUNTER__
>> +__COUNTER__
>> +/*
>> + * check-name: __COUNTER__ #1
>> + * check-command: sparse -E $file
>> + *
>> + * check-output-start
>> +
>> +0
>> +1
>> + * check-output-end
>> + */
>> diff --git a/validation/preprocessor/counter2.c b/validation/preprocessor/counter2.c
>> new file mode 100644
>> index 00000000..9883b682
>> --- /dev/null
>> +++ b/validation/preprocessor/counter2.c
>> @@ -0,0 +1,14 @@
>> +__FILE__ __COUNTER__
>> +#include <counter2.h>
>> +__FILE__ __COUNTER__
>> +/*
>> + * check-name: __COUNTER__ #2
>> + * check-command: sparse -Ipreprocessor -E $file
>> + *
>> + * check-output-start
>> +
>> +"preprocessor/counter2.c" 0
>> +"preprocessor/counter2.h" 1
>> +"preprocessor/counter2.c" 2
>> + * check-output-end
>> + */
>> diff --git a/validation/preprocessor/counter2.h b/validation/preprocessor/counter2.h
>> new file mode 100644
>> index 00000000..447b70ab
>> --- /dev/null
>> +++ b/validation/preprocessor/counter2.h
>> @@ -0,0 +1 @@
>> +__FILE__ __COUNTER__
>> diff --git a/validation/preprocessor/counter3.c b/validation/preprocessor/counter3.c
>> new file mode 100644
>> index 00000000..1449b2d1
>> --- /dev/null
>> +++ b/validation/preprocessor/counter3.c
>> @@ -0,0 +1,13 @@
>> +/*
>> + * check-name: __COUNTER__ #3
>> + * check-command: sparse -Ipreprocessor -E preprocessor/counter1.c preprocessor/counter2.c
>> + *
>> + * check-output-start
>> +
>> +0
>> +1
>> +"preprocessor/counter2.c" 0
>> +"preprocessor/counter2.h" 1
>> +"preprocessor/counter2.c" 2
>> + * check-output-end
>> + */
>>
> 

