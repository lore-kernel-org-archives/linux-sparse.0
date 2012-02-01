From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH 2/2] sparse, llvm: Fix varargs functions
Date: Wed, 01 Feb 2012 08:58:19 -0500
Message-ID: <4F2944FB.7090905@garzik.org>
References: <1328090152-28299-1-git-send-email-penberg@kernel.org> <1328090152-28299-2-git-send-email-penberg@kernel.org> <1328093254.28487.74.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57432 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab2BAN6W (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Feb 2012 08:58:22 -0500
Received: by qadc10 with SMTP id c10so3484810qad.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Feb 2012 05:58:21 -0800 (PST)
In-Reply-To: <1328093254.28487.74.camel@pasglop>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pekka Enberg <penberg@kernel.org>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 02/01/2012 05:47 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2012-02-01 at 11:55 +0200, Pekka Enberg wrote:
>> From: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>>
>> We need to tell llvm about it or it won't generate the proper
>> stack frame&  argument list on some architectures.
>>
>> Cc: Christopher Li<sparse@chrisli.org>
>> Cc: Jeff Garzik<jgarzik@redhat.com>
>> Cc: Linus Torvalds<torvalds@linux-foundation.org>
>> Signed-off-by: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> [ penberg@kernel.org: Fix function pointer calls ]
>> Signed-off-by: Pekka Enberg<penberg@kernel.org>
>> ---
>>   sparse-llvm.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sparse-llvm.c b/sparse-llvm.c
>> index a291a0d..9226a21 100644
>> --- a/sparse-llvm.c
>> +++ b/sparse-llvm.c
>> @@ -79,7 +79,7 @@ static LLVMTypeRef sym_func_type(LLVMModuleRef module, struct symbol *sym)
>>   		arg_type[idx++] = symbol_type(module, arg_sym);
>>   	} END_FOR_EACH_PTR(arg);
>>   	func_type = LLVMFunctionType(ret_type, arg_type, n_arg,
>> -				     /* varargs? */ 0);
>> +				     sym->ctype.base_type->variadic);
>>
>>   	return func_type;
>>   }
>
> Is the above hunk correct ? It was really just a guess, I haven't tested
> that code path :-)

I was wondering that, myself :)  Need coffee, then testing, I suppose :)

	Jeff




