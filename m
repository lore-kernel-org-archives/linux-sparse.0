Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F1320F;
	Tue,  8 Apr 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118714; cv=none; b=o+VNtI8LlQ68tyumSnAhgpIOrsskPU5Jf58s2qLDQxGcXlTamZrauPycVRUyYFTwX5TVOhhLSKgIatL2TLzQrUl8wONuO32yliD4lQeAl9I2suapNTjofbbhVdDNdAoPBr5T7HSjtPGBcMdoI+j6hNzSH4r+sjOxndbceB0u31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118714; c=relaxed/simple;
	bh=ybRUQQKUKuRGlJSWxmR4lIASirnPGkmui80xB93m6Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8joERXGEdYScPrsc3/gJAJXUSTSJDcoWU5MWZkmOCOyUrI5KlHDy/DrOdQ13hCUmxtBRRTZqti76hbmfQEGX3+uclYgnhTBUWe0MG2U4tdWV9xXalR5b/4kgEUgWrzJbC8RZoqG9wSR8n1pbFxuJMlcSvwAvU6sCgDZ7AiHAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XwsaO20j; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XwsaO20j"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 28viuibmeuFHk28vmuJutc; Tue, 08 Apr 2025 15:24:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744118641;
	bh=t77PRiirSzOevQ1dRYJgUaWOGjlnWZD5S6cdK8iJBms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XwsaO20jhP9Oy2otkN3U7VUxi8ePesKx/LRfY33u+i8GzJDwqU/+nhxwkyEg0qTxz
	 G64tQHSHuumeMfWvxHjX9Z6JwYUnPDPKxqvUxGJi6COuIcqm454LfblbYJfHS53Gks
	 WeyNBnPUTlosste3ZVWzgYwMSKM6Vut39KU9SWXn2KkhaHqVg5gjGAY8Z17+asUyaW
	 t23jIOswBhNNx8mUJ3mWIytcxLd97EQlSc80k7AVqHIMGtA9otMiW66PSaCIHPY3vZ
	 BcrvCmP5azOXMije3EfjCK4af6kZzZgxTlLIXaSs2anSQk52WBujM0ixYZCfrrTLSM
	 IWqMYPuyEq35Q==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 Apr 2025 15:24:01 +0200
X-ME-IP: 124.33.176.97
Message-ID: <9dc6f94e-c739-4fdf-8e43-4386d35e02e5@wanadoo.fr>
Date: Tue, 8 Apr 2025 22:23:53 +0900
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] build_bug.h: more user friendly error messages in
 BUILD_BUG_ON_ZERO()
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
References: <20250329-build_bug-v2-1-1c831e5ddf89@wanadoo.fr>
 <202504070945.BAC93C0@keescook>
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
In-Reply-To: <202504070945.BAC93C0@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2025 at 01:46, Kees Cook wrote:
> On Sat, Mar 29, 2025 at 01:48:50AM +0900, Vincent Mailhol wrote:
>> __BUILD_BUG_ON_ZERO_MSG(), as introduced in [1], makes it possible to
>> do a static assertions in expressions. The direct benefit is to
>> provide a meaningful error message instead of the cryptic negative
>> bitfield size error message currently returned by BUILD_BUG_ON_ZERO():
>>
>>   ./include/linux/build_bug.h:16:51: error: negative width in bit-field '<anonymous>'
>>      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>>         |                                                   ^
>>
>> Get rid of BUILD_BUG_ON_ZERO()'s bitfield size hack. Instead rely on
>> __BUILD_BUG_ON_ZERO_MSG() which in turn relies on C11's
>> _Static_assert().
>>
>> Use some macro magic, similarly to static_assert(), to either use an
>> optional error message provided by the user or, when omitted, to
>> produce a default error message by stringifying the tested
>> expression. With this, for example:
>>
>>   BUILD_BUG_ON_ZERO(1 > 0)
>>
>> would now throw:
>>
>>   ./include/linux/compiler.h:197:62: error: static assertion failed: "1 > 0 is true"
> 
> This is so much easier to read! Thanks for this. :)
> 
> If no one else snags it, I can take this via the hardening tree for
> -next once -rc2 is released.

I discussed about this with Andrew by DM.

Andrew can pick it up but for the next-next release. That is to say,
wait for [1] to be merged in v6.16 and then take it to target the v6.17
merge windows.

If you can take it in your hardening-next tree and have it merged in
v6.16, then this is convenient for me.

Just make sure that you send it to Linus after Yury's bitmap-for-next
get merged: https://github.com/norov/linux/commits/bitmap-for-next/

Usually, bitmap changes are merged at the very beginning of the merge
window so that should be OK.


[1] commit b88937277df ("drm/i915: Convert REG_GENMASK*() to fixed-width
GENMASK_U*()")
Link: https://git.kernel.org/next/linux-next/c/b88937277df

Yours sincerely,
Vincent Mailhol

