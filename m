Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769637;
	b=m+AYcrvaqm2cBY3GO/tmN0v/50UwKH09MkVvyCELi4wrkg09rH3ZOe7Ac9i8FCcyv2zK
	 h8pQPPWpY63swHsog4MCRDOYnNV6KN8ymjVuocyrKUT2frsP/wAu7zXgIyI7U1qxvWIwI
	 o+aDHNW0SSq85wlq6XkrE8sNRFwQ5njzpuG3C7Rv1+qcN3yKnXd5xsANe27KUQAN2MWgT
	 Uv4O1sSZNtX2r4b9jlVEqhqY8dPSor1PbsDky9Q5+qPgmLfud998g10qv88O5P+OjPpu1
	 1tdEEV5cBtRcOeywGUZSfMRc+YhqEJoTYzJnCQaIm9VN5MIlwd2LzzHXk4uQKLsTIZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7Wb1v2r/qYRtiPl0jIe1hNPHXwCTAadI+O91fZCXmrY=;
	b=kzfFJDjgbaEbiC4wwpKr7UjePf4QvmsYgWGekPq8+5zaTrvBqDZZCgn1p63mcZnqW6at
	 aZyINvuilfrBNKZ1VwDxCrD1Xt3Fet6UFIDdLaXS96Cd4fY17FlQ8ZeNNk1e2UM38Bn4K
	 VAYz2/CXc4ih69BGNm3KsMdTqn9cvWl3BtxZ/BtvgQ0pkynJ4dDCxPmrRzu1a3VbPxQVl
	 kbjD+grkFKUft4bs97zUivv8GRrKz4mELel/Jqp0bjcIp3ntGDE5SVHprvtIcXCwYWb2d
	 1O5uDDsAdPn7GxSOo9tp/bVvsYJyAoQkgagoh8V1DfPYcQ6eI35QXYbHnuuUjqxuVrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rCMuRByi;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C0606A31B;
	Fri, 23 Oct 2026 15:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9C0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rCMuRByi
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jB6W76QDmzlfvq1;
	Fri, 23 Oct 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792769630; x=1795361631; bh=7Wb1v2r/qYRtiPl0jIe1hNPH
	XwCTAadI+O91fZCXmrY=; b=rCMuRByiWmhZFjeZ5qLIAzfq617H+WMca34naCk3
	+sjbZEgrMBWR+Rg+mW77Y00vOUwDFZ3llPkSwwu3j7QMahdVgK8PsPIA7qiToMLf
	k+cyGtIzD49k1z3b/4X5J+ZB1t9Om2nf3PessiURNiiEmrpIbFEGJRGjMfDWAQyq
	o4hfO4UV9XnA5aQYtlZwCBpO64jNHpP92IBp5+b8KSdUVnuQdmlMoX/wdTFzD/qL
	+jckkjiweaK9ssfqz6B7WWwoROpJ8Myx6YEnrsnqxLltQRl4rxdFPdTQz/ajAtAD
	5kHwdsIKjyHgm5Tz6FmyV0GwCQ0vaj3YB2M13viGoDLbEQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qHTd1dz6LMfl; Fri, 23 Oct 2026 15:33:50 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jB6W13c5Czlfvps;
	Fri, 23 Oct 2026 15:33:49 +0000 (UTC)
Message-ID: <9aa270db-bfc6-4a33-a7f1-225782e9226e@acm.org>
Date: Fri, 23 Oct 2026 08:33:48 -0700
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] include: Replace __ASSEMBLY__ with __ASSEMBLER__
 in non-uapi headers
To: Thomas Huth <thuth@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Chris Li <sparse@chrisli.org>
Cc: soc@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-sparse@vger.kernel.org, llvm@lists.linux.dev
References: <20261023064908.66707-1-thuth@redhat.com>
 <20261023064908.66707-13-thuth@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261023064908.66707-13-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 11:48 PM, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize now
> on the __ASSEMBLER__ macro that is provided by the compilers.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).

For future patch submissions, please include the command that has been
used to modify the code in the patch description. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
