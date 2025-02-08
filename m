Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F46522F;
	Sat,  8 Feb 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983185; cv=none; b=Vc0Q49LNjpgLDO0CIefCw06UDbELRx4YYtXMKqmEmQS9r3+GGmz2uXQUUl+ncrk3eBtqW8lL2BvJdjxyLOjCVfR4gu3mKUcOwSCOoX6uQD20CrETHKlwbOQCWC2L2U04L+jAW/UjUsY/sSQEydW5rqfJlKmqFwNQPRyIqzC/AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983185; c=relaxed/simple;
	bh=oh6DENofgUHMz/8AVMYVJvixcYcOidKWKaEz5d0gzS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJPhW3ygG7BVCkBrYlRGJzSP0sFejJa5ZFX8q2q3OoLJvdmHEqjEVfemaNgBxMWWGp+pX+ezNxNqrzU1+9HAQ6OdBDyLB/W+T4Xsoq7I1fVpMZJHL+W2O7tEefnWKe/piUfZTVvTTz2TePnIVRSLtl0FSzgDK360qtQj/hS4Utk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ovK51B/j; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ovK51B/j"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Yqb4G6s6MzlgTwQ;
	Sat,  8 Feb 2025 02:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738983177; x=1741575178; bh=4FFbTlx5LV+h8M1IzCJ0Rk7p
	GIZ7DeOsHyH8TXJjSDA=; b=ovK51B/jZfMCkN27WBqitmpJjcsYl7CTAtYOJ0ru
	g1M6jfDtDMRRgfL/kHBZaxJ0HvMS1TpS1gQ0+p3wiCNL0lTp1KSSnB4TFJLfMNI1
	c8Y0ZuG46K1qUEPN5obo2BuL13OonTffTaTNhilC7u73/vgetPQztL9ZlPk1uX/6
	991DT1LAkrZpAv1+UJz3KoVldfu/sIV5zeX8GGq98ehGtCDWNvUlf2gtlkKl/Rgz
	p9ew5F56/F8sRtxZfKxQwO0vIhcPY1KdID2OrYF8FIXlbNtjc64c46NBpZHphrVN
	2kO0yXLiAaNweHv9mbUf1gkZgyevGNkd5+0XUFOPRH1XgA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kc81cGdEH4Xr; Sat,  8 Feb 2025 02:52:57 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Yqb434XJHzlgTwF;
	Sat,  8 Feb 2025 02:52:50 +0000 (UTC)
Message-ID: <e56577db-b94c-4f38-868b-dd3be65f780d@acm.org>
Date: Fri, 7 Feb 2025 18:52:48 -0800
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] refcount: attempt to avoid imbalance warnings
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Alexander Aring <aahringo@redhat.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, thunder.leizhen@huawei.com,
 jacob.e.keller@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 Sparse Mailing-list <linux-sparse@vger.kernel.org>,
 cluster-devel <cluster-devel@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630135934.1799248-1-aahringo@redhat.com>
 <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/22 9:34 AM, Linus Torvalds wrote:
> On Thu, Jun 30, 2022 at 6:59 AM Alexander Aring <aahringo@redhat.com> wrote:
>>
>> I send this patch series as RFC because it was necessary to do a kref
>> change after adding __cond_lock() to refcount_dec_and_lock()
>> functionality.
> 
> Can you try something like this instead?
> 
> This is two separate patches - one for sparse, and one for the kernel.
> 
> This is only *very* lightly tested (ie I tested it on a single kernel
> file that used refcount_dec_and_lock())
> 
>                  Linus

(replying to an email from two years ago -- see also
https://lore.kernel.org/linux-kernel/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/)

Hi Luc,

Are there any plans to add support for __cond_acquires() in sparse?

Marco Elver (Cc-ed) and I are looking into enabling the Clang 
-Wthread-safety compiler flag for Linux kernel code. If we want to keep the
sparse locking annotations, a first step would be to convert all
__cond_lock() annotations into __cond_acquires(). When I tried to make
that change I noticed that sparse does not yet support
__cond_acquires(). Hence my question about the plan to support
__cond_acquires() in sparse?

Thanks,

Bart.
