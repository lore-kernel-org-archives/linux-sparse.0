Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2962FB99A
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180300; cv=none; b=j9LdALAdc9kyGv4quugOCMWTsIoiAe6qJZLorIpgrAI8YpyHdZQUTHkZyrxPaDXvHNb1yNzo/UMCehQP0jpPJUKfW5aXPoiOFDyzVXkii57RHKBn7pdma7q/qupXRwUJiZwtFship8kf9AwORLMmx4VJzRCIa7OMHXnclGdI0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180300; c=relaxed/simple;
	bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0hqeK+mNTl+T5ilwRFIKqpLLaUBLhqNqhQKDI1365JC6OpXpyuWP31n5+pJ5erhegYcTURmhFWfpN6h5QQExOp05Jkd4TYKayo9zmPj4MdYVG0oeby4BKTJ+Xx2Hpg35dtcrwoPKq+DBR7T4vtfRoFeivaxsqUAiEm2AkxOpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdmRikKo; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdmRikKo"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a2ea96930cso22706955ad.2
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180295; x=1766785095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=hdmRikKof1NCOF8csgsz0QaIQbkn3npdDSD2zPV9QtXzYRhlr2fqiQ078la1G3gI4H
         KLwjEi0N6X7TyNb5gaIcGne+gqCRl8yjP4bPw4gl85vCm9v/RR7i9d8vAohVFmEK+XLe
         0j1FejphZMV+eLrM/etxLWRgPv0WIT4HslD0AX19ySzvHjuoQ3Ca5+WU89yFFmqwdi+P
         +K13/FopXb+VtFX/deUCJMA6+Yh6iIRPDeWPn6xlMWeq+xRGYcw2TNnQuGGkkzzPkJO4
         8DMZ+yeRKsQgOxMH7Eq2ox/3USHl2TKTrBpTwxLfKcQu7jI9zCi62E8D8jyPmRlu+ZI1
         66TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180295; x=1766785095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBHXkRgMesGUJGSlI+YkckhHJhyJOUbeeY6s/H5FeUc=;
        b=eXNoAeWr2il+S1IqdouPYzu3X/JTRxwcB1C5+L9u5BFQLW88tPopMZIrZFjzFotV5e
         4ejL5Vy/M3kas8XFnSBCtnIFKfGSRBcbMj4Fu8i8+VSpCfMIrH0JkzWcGon8a9ttBlBb
         428duSyD/jN0gk9o6ddqct3WiGo2STk851DHWgOv8g0CKiGCyRQEaQ4ubCj1B7URrcPm
         36/Z/Iu1/4b9D1K+Zm0vKwkCE9CtiMZKfQGBktzOKDFWvEjQ/sdSEamnxNmnhfcMczuj
         FnBHJ/tfPY0UYvVnOVcb5KlTV00kl+awvfKPKQ7ANBGZyP/FUHiVdFvjJvQhi7C+Q2RH
         naqg==
X-Forwarded-Encrypted: i=1; AJvYcCUMz4koRQlk9m7UiC3WIGTQVsgCbVNEsmOfaFOEg6BmHMjbdRepuROwQfWoqLlv44JcQ6hkaHlMZwc8B8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuaK7NNXf3CDioJsQyX2jp+oQ4qB0C+bkttrXzFav1GhsgI17
	lbDHrqrYVzrE6pfRSxa6NFpJURSIPMBRNVlKIP/JjeCRkMXAESxl5JXk
X-Gm-Gg: AY/fxX7RSRvCccOWj1d2yZJfJ9FWL5qfOjmpZjQS+ml32pKeVUyDcGp2GxpJ0+/LETB
	DZ5PAi+sevNVYT3hIl4L/F9+NLQc56ci86RvElVvdb8kbT+cIPc1RZTioKY6HH1P3wCFAUl6Xpt
	c/zj2WJ9umRM+xbhkPy3jOM4XPjRg0II9U8Nu/moqMl+7li5Wm16+UNO+7zT5tzsc+mDUEAc9D3
	LDMWNEvSDNtlNYKdxVjvSxyviFT5eAuY0FcNnpM7jD/ImK+cFOaO96UpL6MfyYKHWlOMiLkFgMa
	D8PO6htL8EyjpkRDiuTEgFUMfcqi/QqSO5B+Z7tfBjtwVG63CeX8ceRyjhDMFhcSiwCdNWTx39X
	G05+uo+xI3XROUgijzkD1F3VkrJTM7AeLjbXC7bCCLNoqbpnXPtNibKrCJy3hXzTzFhcGEClvBX
	hqT0t99NDknD8wWI8qEnsY3haw+v8xx+mrAiQhPVY0GbnEpLcsw7suCpXsREP2nzMV9HG+bTBBM
	C35UGFm8vN5CaoVPW9GWlBI9W2hC3KxJE5SsQpJhX6ljRrMykayusTGes6o39hLFvl1nvLt/EMM
	rXU=
X-Google-Smtp-Source: AGHT+IGivulZwqOvq9TkwT/0JBobQprm3JRJ6VtJUw4ydSXEmlT/iKTWxEeMw8/Q4ZWRYLdEwZEKQQ==
X-Received: by 2002:a05:7022:e0c:b0:11a:f5e0:dc8 with SMTP id a92af1059eb24-121722f462emr3455845c88.28.1766180295388;
        Fri, 19 Dec 2025 13:38:15 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm12051531c88.1.2025.12.19.13.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:38:14 -0800 (PST)
Message-ID: <34cda24f-acdc-4049-9869-b666b08897d9@gmail.com>
Date: Fri, 19 Dec 2025 14:38:12 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] compiler-context-analysis: Remove Sparse support
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-24-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20251219154418.3592607-24-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> Remove Sparse support as discussed at [1].

Kernel patch descriptions should be self-contained. In other words, the
conclusion from [1] should be summarized in the patch description
instead of only referring to that discussion with a hyperlink.

Thanks,

Bart.
