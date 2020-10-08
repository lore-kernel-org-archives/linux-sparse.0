Return-Path: <SRS0=iil9=DP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A281C4363C
	for <linux-sparse@archiver.kernel.org>; Thu,  8 Oct 2020 06:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF3F2083B
	for <linux-sparse@archiver.kernel.org>; Thu,  8 Oct 2020 06:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJHGgH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 8 Oct 2020 02:36:07 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49665 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJHGgH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Oct 2020 02:36:07 -0400
X-Greylist: delayed 67402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 02:36:05 EDT
X-Originating-IP: 78.45.89.65
Received: from [192.168.1.23] (ip-78-45-89-65.net.upcbroadband.cz [78.45.89.65])
        (Authenticated sender: i.maximets@ovn.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7E63160005;
        Thu,  8 Oct 2020 06:36:03 +0000 (UTC)
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ilya Maximets <i.maximets@ovn.org>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
 <20201007230920.lsclffcffqeywpev@ltop.local>
From:   Ilya Maximets <i.maximets@ovn.org>
Message-ID: <c1d215cc-b498-c48f-dc91-b98ad0627c2d@ovn.org>
Date:   Thu, 8 Oct 2020 08:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007230920.lsclffcffqeywpev@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 10/8/20 1:09 AM, Luc Van Oostenryck wrote:
> On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
>> There is a common pattern on how to allocate memory for a flexible-size
>> structure, e.g.
>>
>>   union {
>>       struct flex f;  /* Structure that contains a flexible array. */
>>       char buf[MAX_SIZE];  /* Memeory buffer for structure 'flex' and
>>                               its flexible array. */
>>   };
>>
>> There is another exmaple of such thing in CMSG manpage with the
>> alignment purposes:
>>
>>   union {         /* Ancillary data buffer, wrapped in a union
>>                      in order to ensure it is suitably aligned */
>>       char buf[CMSG_SPACE(sizeof(myfds))];
>>       struct cmsghdr align;
>>   } u;
>>
>> Such unions could form an array in case user wants multiple
>> instances of them.  For example, if you want receive up to
>> 32 network packets via recvmmsg(), you will need 32 unions like 'u'.
>> Open vSwitch does exactly that and fails the check.
>>
>> Disabling this check by default for unions.  Adding new option
>> -Wflex-union-array to enable it back.  This option works only
>> if -Wflex-array-array enabled (which is default behavior).
>>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
>>
>> Not sure if this is a best way to fix the issue, but it works fine for
>> openvswitch project. The actual code in question that makes sparse fail
>> OVS build could be found here:
>>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238
> 
> This fixes your problem for -Wflexible-array-array but the same
> will happen with -Wflexible-array-sizeof (and you're using sizeof()
> on such flexible unions) and -Wflexible-array-nested.

I thought that it will fail some other checks too, but for some reason
it doesn't.  But, yes, you're right, It sounds safer to disable all
of them to avoid possible issues in the future since we're actually
using these unions.

> 
> So, what I'm proposing is a flag to simply disable all warnings
> concerning flexible arrays with union types. I've also changed
> the flag to -Wflexible-array-union to make it clear it's closely
> related to -Wflexible-array-{array,nested,union}. I've also make
> it to be enabled by default (but I haven't made my mind on it).

I thought about naming the option 'flexible-array-union-array' in my
original patch, but that doesn't look good.

Patch below looks good to me (one nitpick inline) and works fine if
I'm disabling the option.  I'd like it disabled by default, but
I'm completely biased, so it's up to you.
We have a TravisCI instance that uses sparse, so we'll need to disable
this option there and update our documentation to suggest this new flag
to developers.  Sure, I'd like to not do that. :)

> 
> 
> From 286903619edce5e723b3467e82bd6f09d4ae0031 Mon Sep 17 00:00:00 2001
> From: Ilya Maximets <i.maximets@ovn.org>
> Date: Wed, 7 Oct 2020 13:52:34 +0200
> Subject: [PATCH] flex-array: allow arrays of unions with flexible members.
> 
> There is a common pattern on how to allocate memory for a flexible-size
> structure, e.g.
> 
>   union {
>       struct flex f;  /* Structure that contains a flexible array. */
>       char buf[MAX_SIZE];  /* Memory buffer for structure 'flex' and
>                               its flexible array. */
>   };
> 
> There is another example of such thing in CMSG manpage with the
> alignment purposes:
> 
>   union {         /* Ancillary data buffer, wrapped in a union
>                      in order to ensure it is suitably aligned */
>       char buf[CMSG_SPACE(sizeof(myfds))];
>       struct cmsghdr align;
>   } u;
> 
> Such unions could form an array in case user wants multiple
> instances of them.  For example, if you want receive up to
> 32 network packets via recvmmsg(), you will need 32 unions like 'u'.
> Open vSwitch does exactly that and fails the check.
> 
> So, add a new option, -W[no-]flex-array-union, to enable or disable
> any warning concerning flexible arrays and unions. This option needs
> at least one of -Wflex-array-{array,nested,union} to be enabled in
> order to have any effect.
> 
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  options.c                         |  2 ++
>  options.h                         |  1 +
>  sparse.1                          |  9 +++++++++
>  symbol.c                          |  2 +-
>  validation/flex-union-array-no.c  |  9 +++++++++
>  validation/flex-union-array-yes.c | 11 +++++++++++
>  validation/flex-union-array.h     | 11 +++++++++++
>  7 files changed, 44 insertions(+), 1 deletion(-)
>  create mode 100644 validation/flex-union-array-no.c
>  create mode 100644 validation/flex-union-array-yes.c
>  create mode 100644 validation/flex-union-array.h

Since you renamed the option, it might make sense to rename
files to 'flex-array-union...'.

> 
> diff --git a/options.c b/options.c
> index b46900b973a6..2736d38c0d4e 100644
> --- a/options.c
> +++ b/options.c
> @@ -103,6 +103,7 @@ int Wexternal_function_has_definition = 1;
>  int Wflexible_array_array = 1;
>  int Wflexible_array_nested = 0;
>  int Wflexible_array_sizeof = 0;
> +int Wflexible_array_union = 1;
>  int Wimplicit_int = 1;
>  int Winit_cstring = 0;
>  int Wint_to_pointer_cast = 1;
> @@ -846,6 +847,7 @@ static const struct flag warnings[] = {
>  	{ "flexible-array-array", &Wflexible_array_array },
>  	{ "flexible-array-nested", &Wflexible_array_nested },
>  	{ "flexible-array-sizeof", &Wflexible_array_sizeof },
> +	{ "flexible-array-union", &Wflexible_array_union },
>  	{ "implicit-int", &Wimplicit_int },
>  	{ "init-cstring", &Winit_cstring },
>  	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
> diff --git a/options.h b/options.h
> index d23ed472eaac..70c6ce9bec37 100644
> --- a/options.h
> +++ b/options.h
> @@ -102,6 +102,7 @@ extern int Wexternal_function_has_definition;
>  extern int Wflexible_array_array;
>  extern int Wflexible_array_nested;
>  extern int Wflexible_array_sizeof;
> +extern int Wflexible_array_union;
>  extern int Wimplicit_int;
>  extern int Winit_cstring;
>  extern int Wint_to_pointer_cast;
> diff --git a/sparse.1 b/sparse.1
> index 9b1a59c6b9d4..ed528fd19dde 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -278,6 +278,15 @@ possibly recursively.
>  Sparse does not issue these warnings by default.
>  .
>  .TP
> +.B -Wflexible-array-union
> +Enable the warnings regarding flexible arrays and unions.
> +To have any effect, at least one of \fB-Wflexible-array-array\fR,
> +\fB-Wflexible-array-nested\fR or \fB-Wflexible-array-sizeof\fR must also
> +be enabled.
> +
> +Sparse does issue these warnings by default.
> +.
> +.TP
>  .B \-Winit\-cstring
>  Warn about initialization of a char array with a too long constant C string.
>  
> diff --git a/symbol.c b/symbol.c
> index 97c2e35d3570..9ae827c1d764 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -214,7 +214,7 @@ static struct symbol * examine_struct_union_type(struct symbol *sym, int advance
>  	if (info.flex_array) {
>  		info.has_flex_array = 1;
>  	}
> -	if (info.has_flex_array)
> +	if (info.has_flex_array && (!is_union_type(sym) || Wflexible_array_union))
>  		sym->has_flex_array = 1;
>  	sym->bit_size = bit_size;
>  	return sym;
> diff --git a/validation/flex-union-array-no.c b/validation/flex-union-array-no.c
> new file mode 100644
> index 000000000000..2857fd9b91a0
> --- /dev/null
> +++ b/validation/flex-union-array-no.c
> @@ -0,0 +1,9 @@
> +#include "flex-union-array.h"
> +
> +/*
> + * check-name: flex-array-union-no
> + * check-command: sparse -Wflexible-array-array -Wno-flexible-array-union $file
> + *
> + * check-error-start
> + * check-error-end
> + */
> diff --git a/validation/flex-union-array-yes.c b/validation/flex-union-array-yes.c
> new file mode 100644
> index 000000000000..c8aa7966c811
> --- /dev/null
> +++ b/validation/flex-union-array-yes.c
> @@ -0,0 +1,11 @@
> +#include "flex-union-array.h"
> +
> +/*
> + * check-name: flex-array-union-yes
> + * check-command: sparse -Wflexible-array-array -Wflexible-array-union $file
> + *
> + * check-error-start
> +flex-union-array-yes.c: note: in included file:
> +flex-union-array.h:11:17: warning: array of flexible structures
> + * check-error-end
> + */
> diff --git a/validation/flex-union-array.h b/validation/flex-union-array.h
> new file mode 100644
> index 000000000000..b2a74d1a06ea
> --- /dev/null
> +++ b/validation/flex-union-array.h
> @@ -0,0 +1,11 @@
> +struct s_flex {
> +	int i;
> +	long f[];
> +};
> +
> +union s {
> +	struct s_flex flex;
> +	char buf[200];
> +};
> +
> +static union s a[2];
> 

