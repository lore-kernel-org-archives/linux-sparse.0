Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11B1632E2;
	Wed, 13 Nov 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519864; cv=none; b=FpQApop31A1v/7IA5/dfiPZ+6rvABeL6Pcy/tZepxjXZwb9MW0e5v2KNa1xRJKKGUaouMwgxQETBaqhY6XdgXkcVSHGo5TJOKIVxix6TR5gAk5SYSJf5MUSajgeb06REq5lH1NgfuijuZjAVPFuCEqN//+UXtgC3Aw20B3MwHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519864; c=relaxed/simple;
	bh=3e7ddZ56JgtwOGpWytDdsV5++LuwyeLu5bKVRLfduUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxIbaxuRwk0jkGybZqUitX9t2OE3Zpjc9FNRpVSBdjkcp7tnUVsBZh1lOBNszm92ekVxh1cStiCyr1912YXL/mBW7V6iLmu6MVzHPR04siYFEY/3CTpsR6D596+CE6bzmiC9MHNb4c5yFBA3w3PKNKmyXExfVyRmh80bZmMeCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IAVtciNj; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IAVtciNj"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BHPXt6HUsl38xBHPYtfY0a; Wed, 13 Nov 2024 18:44:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731519855;
	bh=8yt31LK7mwsmtd242ieGzXI5Eg3ZJTkLmfaoG3DU2MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IAVtciNjTIcSi0OMYtShFFvANL1WTWHXKXw62leUr0fHYHXwtkykikT+4aXIED02i
	 8dFMZBrHQVpE7fYVJR/pJAc1bWkYhDRKDCgfO44y/xCZzf8Vyljwo1GB2lABaaQyTH
	 ah9ygaO9lldWu+6Mtx8zyXycRnQ7DLeTKO/xOxZeRknrxWeiRu3TI0UP+O2pZ49VCf
	 iE3lRQwqINKnyMeIkHdQ3socUS9I8lrAavu0yo2dOxv3dEbDieYb+eS20/qOCcDpSy
	 lVmBAldoml+3kluEzKe/VZCEha0CoIOmjGvja5kOXnG4C+ln8bDRwxZk218SiK8RSU
	 WY152Xqb7bi9Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Nov 2024 18:44:15 +0100
X-ME-IP: 124.33.176.97
Message-ID: <2fd6212c-6406-4435-8cde-8a07aa16d933@wanadoo.fr>
Date: Thu, 14 Nov 2024 02:44:10 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] compiler.h: add _static_assert()
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <20241112190840.601378-4-mailhol.vincent@wanadoo.fr>
 <20241112190840.601378-5-mailhol.vincent@wanadoo.fr>
 <ZzO5390yVTqNbgJl@yury-ThinkPad>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <ZzO5390yVTqNbgJl@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 at 05:26, Yury Norov wrote:
> On Wed, Nov 13, 2024 at 04:08:39AM +0900, Vincent Mailhol wrote:
>> __builtin_constant_p() is known for not always being able to produce
>> constant expression [1] which lead to the introduction of
>> __is_constexpr() [2]. Because of its dependency on
>> __builtin_constant_p(), statically_true() suffers from the same
>> issues.
>>
>> For example:
>>
>>    void foo(int a)
>>    {
>>    	 /* fail on GCC */
>>    	BUILD_BUG_ON_ZERO(statically_true(a));
>>
>>    	 /* fail both clang and GCC */
>>    	static char arr[statically_true(a) ? 1 : 2];
>>    }
>>
>> For the same reasons why __is_constexpr() was created to cover
>> __builtin_constant_p() edge cases, __is_constexpr() can be used to
>> resolve statically_true() limitations.
>>
>> Note that, somehow, GCC is not always able to fold this:
>>
>>    __is_constexpr(x) && (x)
>>
>> It is OK in BUILD_BUG_ON_ZERO() but not in array declarations or in
>> static_assert():
>>
>>    void bar(int a)
>>    {
>>    	/* success */
>>    	BUILD_BUG_ON_ZERO(__is_constexpr(a) && (a));
>>
>>    	/* fail on GCC */
>>    	static char arr[__is_constexpr(a) && (a) ? 1 : 2];
>>
>>    	/* fail on GCC */
>>    	static_assert(__is_constexpr(a) && (a));
>>    }
>>
>> Encapsulating the expression in a __builtin_choose_expr() switch
>> resolves all these failed test.
>>
>> Declare a new _statically_true() macro which, by making use of the
>> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
>> constant expression.
> So, maybe name it const_true() then?


OK. I pretty like the _statically_true() because the link with 
statically_true() was obvious and the _ underscore prefix hinted that 
this variant was "special". But I have to admit that the const_true() is 
also really nice, and I finally adopted it in the v4.

>> It should be noted that statically_true() still produces better
>> folding:
>>
>>    statically_true(!(var * 8 % 8))
>>
>> always evaluates to true even if var is unknown, whereas
>>
>>    _statically_true(!(var * 8 % 8))
>>
>> fails to fold the expression and return false.
>>
>> For this reason, usage of _statically_true() be should the exception.
>> Reflect in the documentation that _statically_true() is less powerful
>> and that statically_true() is the overall preferred solution.
>>
>> [1] __builtin_constant_p cannot resolve to const when optimizing
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
>>
>> [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
>>
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>> Bonuses:
>>
>>    - above examples, and a bit more:
>>
>>        https://godbolt.org/z/zzqM1ajPj
>>
>>    - a proof that statically_true() does better constant folding than _statically_true()
>>
>>        https://godbolt.org/z/vK6KK4hMG
>> ---
>>   include/linux/compiler.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 4d4e23b6e3e7..c76db8b50202 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -308,6 +308,20 @@ static inline void *offset_to_ptr(const int *off)
>>    */
>>   #define statically_true(x) (__builtin_constant_p(x) && (x))
>>   
>> +/*
>> + * Similar to statically_true() but produces a constant expression
>> + *
>> + * To be used in conjunction with macros, such as BUILD_BUG_ON_ZERO(),
>> + * which require their input to be a constant expression and for which
>> + * statically_true() would otherwise fail.
>> + *
>> + * This is a tradeoff: _statically_true() is less efficient at
>> + * constant folding and will fail to optimize any expressions in which
>> + * at least one of the subcomponent is not constant. For the general
>> + * case, statically_true() is better.
> I agree with Rasmus. Would be nice to have examples where should I use
> one vs another right here in the comment.


I rewrote the full set of examples in v4. I added the godbolt link in 
the patch description and I cherry picked what seems to me the two most 
meaningful examples and put them in the macro comment. Let me know what 
you think.

Yours sincerely,
Vincent Mailhol

