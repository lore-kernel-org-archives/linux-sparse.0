Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D23234;
	Tue, 31 Dec 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621104; cv=none; b=Z1mktpBuW/43oAM0dPFh2BxBlgcVIQRz0P6rt2fTCcPJxICjCKBz+CgMl9DV7uE7DrFDDt8cgQELAEECH+MqbqvNK4Wc0sghflVJcOv8Eogs42W08i0vcSKSxP/K5TKqLJS6jFgBGaUv9lFJrU0qaNS0go5GrCizk6vgFWzhL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621104; c=relaxed/simple;
	bh=dcuSNg7QlDOpDAPSy1OPqkFBnuN/PSi7+ub/RohTO7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQX6R8I9XwHURavpdKjzwHJ5LR2f94WxioP23yuGB37EimWNWrMKsIZVSlTNb61Rt9Xi9R1bOOqO+LEngGP+1DJD/hlmPZa0kExa4kqfe+JtjglcVTfZzWFNllFysGZsaAvEPWwSw0q3blDl/qvT5cj3lGtCfWpO1TjLDgDakh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LDKgvTAc; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LDKgvTAc"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id SUKTtBGsSTjIXSUKYt2LbW; Tue, 31 Dec 2024 05:58:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735621093;
	bh=m0ycUAsuc6/KKPuOeQxYdHyPN+dS5DsyekWsOtMCmP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LDKgvTAcHoXPB/wResAKtM99WySOoD767THwZxCWIIrH1NrvskduwVSLkhXzvhcG+
	 pcQZrLJWeyOhK1cFwi2oEjjfhb2BJ3u615Bcvdbl1ifQlHEKkNWIGj6Vp6WdEJSmr9
	 RJoJTeSzSltzP/0x/BF7+6AqlWNGiYIKsK1N6c8+DIVScU0cHxZfMGOzaf3FQ0CzSI
	 yJ39JK9p7NZhknCjnPJudp20JUDFBihxB1Wj0Bqp3j7NdId82cBN+P3Yki6XX1haFl
	 nvDTiWUVZWng4WxynMoHOl7x0Gft4f8mufUc4CnFSazmOp7n2mppgN0Rmq8gpjTaPj
	 7UpMFEX6oRfNw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 31 Dec 2024 05:58:13 +0100
X-ME-IP: 124.33.176.97
Message-ID: <f8d71557-b767-422d-976f-ab9902da87b8@wanadoo.fr>
Date: Tue, 31 Dec 2024 13:58:04 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Rikard Falkeborn <rikard.falkeborn@gmail.com>
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr>
 <ZzT1wZ-WQi8zuwqG@yury-ThinkPad> <Z3LnNBWn8dHZIo7E@yury-ThinkPad>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <Z3LnNBWn8dHZIo7E@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2024 at 03:32, Yury Norov wrote:
> On Wed, Nov 13, 2024 at 10:53:55AM -0800, Yury Norov wrote:
>> On Thu, Nov 14, 2024 at 02:18:32AM +0900, Vincent Mailhol wrote:
>>> __builtin_constant_p() is known for not always being able to produce
>>> constant expression [1] which led to the introduction of
>>> __is_constexpr() [2]. Because of its dependency on
>>> __builtin_constant_p(), statically_true() suffers from the same
>>> issues.
>>>
>>> For example:
>>>
>>>   void foo(int a)
>>>   {
>>>   	 /* fail on GCC */
>>>   	BUILD_BUG_ON_ZERO(statically_true(a));
>>>
>>>   	 /* fail on both clang and GCC */
>>>   	static char arr[statically_true(a) ? 1 : 2];
>>>   }
>>>
>>> For the same reasons why __is_constexpr() was created to cover
>>> __builtin_constant_p() edge cases, __is_constexpr() can be used to
>>> resolve statically_true() limitations.
>>>
>>> Note that, somehow, GCC is not always able to fold this:
>>>
>>>   __is_constexpr(x) && (x)
>>>
>>> It is OK in BUILD_BUG_ON_ZERO() but not in array declarations nor in
>>> static_assert():
>>>
>>>   void bar(int a)
>>>   {
>>>   	/* success */
>>>   	BUILD_BUG_ON_ZERO(__is_constexpr(a) && (a));
>>>
>>>   	/* fail on GCC */
>>>   	static char arr[__is_constexpr(a) && (a) ? 1 : 2];
>>>
>>>   	/* fail on GCC */
>>>   	static_assert(__is_constexpr(a) && (a));
>>>   }
>>>
>>> Encapsulating the expression in a __builtin_choose_expr() switch
>>> resolves all these failed tests.
>>>
>>> Define a new const_true() macro which, by making use of the
>>> __builtin_choose_expr() and __is_constexpr(x) combo, always produces a
>>> constant expression.
>>>
>>> It should be noted that statically_true() is the only one able to fold
>>> tautologic expressions in which at least one on the operands is not a
>>> constant expression. For example:
>>>
>>>   statically_true(true || var)
>>>   statically_true(var == var)
>>>   statically_true(var * 0 + 1)
>>>   statically_true(!(var * 8 % 4))
>>>
>>> always evaluates to true, whereas all of these would be false under
>>> const_true() if var is not a constant expression [3].
>>>
>>> For this reason, usage of const_true() be should the exception.
>>> Reflect in the documentation that const_true() is less powerful and
>>> that statically_true() is the overall preferred solution.
>>>
>>> [1] __builtin_constant_p cannot resolve to const when optimizing
>>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
>>>
>>> [2] commit 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
>>> Link: https://git.kernel.org/torvalds/c/3c8ba0d61d04
>>>
>>> [3] https://godbolt.org/z/c61PMxqbK
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>> For the series:
>>
>> Reviewed-by: Yury Norov <yury.norov@gmail.com>
>>
>> If no objections, I'll move it with my tree.
> 
> This is already in my branch, but there was a discussion after I pulled
> it. Can you guys tell me what is your conclusion on that? Should I
> keep it in the branch, or drop?

I see... Thanks for asking!

After receiving criticism on this series, I was assuming that I had to
rework it. But if given the option, I definitely prefer if you keep it
in your tree.

The new series [1] I sent depends on this patch from David:

  https://git.kernel.org/akpm/mm/c/c108f4c2947a

which is causing build failure in linux-next. Because of that, I put my
new series of hiatus. And the merge windows approaches, so I would
rather like that we just keep this series of two patches for 6.13 and
that I continue the bigger refactor of is_const() in the 6.14 cycle (by
then, the dependencies on David patch will hopefully be fixed).

Note that the new series does not conflict with this one. So if this
series gets merged first, I see only benefit: it will offload some work
and make the new series a bit smaller.

[1]
https://lore.kernel.org/all/20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr/


Yours sincerely,
Vincent Mailhol

