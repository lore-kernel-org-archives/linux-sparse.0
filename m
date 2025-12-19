Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C42DAFCA
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766187620; cv=none; b=j28nCM7iZuPVnA3pGjiVbH+BfJlu1NBmrUqRscpSqh3TCE+8C/QNHobWzyOJvp/iN2zVeKWovN2bh2kPcCrs16GB0imcEvFaoQIWcXOi3JB7BVJaows7qRiU8+ZhjdniB7GeeKdy/ktCiBzthRaCsh4zgskhub6he7H8xzdWhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766187620; c=relaxed/simple;
	bh=kqYAQZ609rJygFWC7CbHOEHNatKsPADzGjHUdHPU3XE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qOtdI3Q5ZyTWnUOLz/asJPQ0FEXGTGx973GbHcYx5qgZW83pdnRW6Hj1XIN6TKQcpLO2+968bkmuke4yfx/Ov0rSMlpCEd+ilc3rM65iI9Jx2unwtAPfb+dFe+eMrZd+pDPo5CuoPZooEe8Y73RDD0O3i6a9DzsikSSUXttySGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQyvMghs; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQyvMghs"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so2360414a12.0
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766187618; x=1766792418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=CQyvMghsSbX5BIuTDI2Su+/M3ooSPbtl2aW3aXcUu++7Bheq5ougSdTezJ8VPC9fh2
         TD/ImfxVx2Cc2t8jQzjQ6j26ReGxmApxbdmv9GhUN0Rq+26uUk7pfd14G61007MneUpW
         9Kx34RT5FPYxXIYBkMO2XZj+U/R3/Ttq0eyhsa+eRpuJVmEheOcBAwt2xVLN14rHOJTD
         bvj6RnQCTKAOH1rQYrNiGEh5KSGaJWK8Rx9U99FFTKXMfL5aMOdyBfg5VSNWdjxsFCNF
         e4B3sQDOXnw/sQX/53MyEbRPr2dpStu9Ku/pbecX+7/Cr3PVosfS9gz4BqnPc/KC+PGe
         iGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766187618; x=1766792418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjhz9NvSIj1nkwStS3EsBbpnWvjG3hzX9yFNjSmaNpQ=;
        b=DR82j7Nb9DvVxk6wTkaLp2E4wOYzIlu94dftTEc08zNnTZQYfNcpZh8aAcK5kWEr0F
         rIOqUpZBbndml/56eGhJgHzYAoi5L85IO367HZnj9oP+pw0VQ3+Bvb+bpENfcJjiiUWk
         DEUDElxezJimzTRuyafCnnizHFDdAGor1stc+7vNLQVyHp9dON0HzdqfEYn7kS+0Q2xM
         nfGejrUBiXK692bAcadxbPDniPgsuEvcAwjeCbSnOV4aWJQ9dXaVtEenCx6AxUYF8g0h
         rDRp4fuU0R7ydeKAb9DA9pMA8uauO6WaNXCocsCKqcSe/lUw5Cp2ckmTxzJUiJ9s6Pk2
         7n4w==
X-Forwarded-Encrypted: i=1; AJvYcCV7cE6UtXIVgQMePpg2OQVcuDKw4ItuYCLWx6rAjHQhNGzufyTgXcqi27jqpPVYH1zTklksS88dlNkTBgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYF0SdBanBccQgK8+RBUj2YTuMYolTIVslNmADFEa8HZdP1LXG
	p6JyF6rRGVOiqhc68iUyCIfy85M5tHL6gCV59T3Eo3dqwdhgvY6sruYzhrp74pQUnzs=
X-Gm-Gg: AY/fxX6qPYjo49oDPNmADWoHA7m3a86Sk9ysADph5A03XWdaO8aeawMNJBP0aMHiSp4
	IW28ZA4AZ2ppo12byf89HZKZs+ZiCvM/F2kUop8bVX6/bOlmN3lmTobVR836aSyoay54cN5KOBs
	6/KDOvJoHcy/wWX3WGpRxBX4C03aFE78pn22cRhaq9zTTa0o8xZTeLG6kJuxrO7b+71q+WQsxKL
	6iVAijRu3VKo9blyXQIMo1ehQ2AnmVfDb2+SyfQJtGfsAZoRuRlL2O6QyhhP6f4t0THIRms2/Qs
	LOnsilw4jOaXF0M67yVtWNeo3YCA/+rBisTOEV7Ug5DCMsSoxECVVkTdLlvBMWiNT8x+j86x9XO
	4NJjyn+//INys/kFQYgKar+QTVT4N0hTKRVa3a8umL/F+nwhWlCkL6K0piB4J3b2O+SCb9ZVU3X
	ohAEr8KEmAUUI7YjAqcN5Wy7+i8BTKGAVpS9KTWUwaQd+CNsClTVJRY2wGI2QB06RnbKan/5Cuc
	AoVKOUyULVc54VSVGtrr6tkXATpHqQCJzGDS+bvgOvy1hF8isBR9whmpgFL4E7tTAPgZEJaJ2lV
	7b4=
X-Google-Smtp-Source: AGHT+IFD9VEfhTkWGAUJ+KrkgUpiheofAxrSZVwNtEffu0+8gx+hrdlGu9tKXSDKwQO+mDr4xt9mXg==
X-Received: by 2002:a05:7022:3a83:b0:11c:b397:2657 with SMTP id a92af1059eb24-121722be81emr4954809c88.22.1766180747284;
        Fri, 19 Dec 2025 13:45:47 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10260116eec.2.2025.12.19.13.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:45:46 -0800 (PST)
Message-ID: <ae957ee5-cb47-433f-b0b3-f4ac8ec7116b@gmail.com>
Date: Fri, 19 Dec 2025 14:45:45 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-9-elver@google.com>
 <17723ae6-9611-4731-905c-60dab9fb7102@acm.org>
 <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 1:02 PM, Marco Elver wrote:
> On Fri, 19 Dec 2025 at 21:26, Bart Van Assche <bvanassche@acm.org> wrote:
>> On 12/19/25 7:39 AM, Marco Elver wrote:
>>> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
>>> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
>>
>> Given the "one change per patch" rule, shouldn't the annotation fixes
>> for rwlock operations be moved into a separate patch?
>>
>>> -typedef struct {
>>> +context_lock_struct(rwlock) {
>>>        arch_rwlock_t raw_lock;
>>>    #ifdef CONFIG_DEBUG_SPINLOCK
>>>        unsigned int magic, owner_cpu;
>>> @@ -31,7 +31,8 @@ typedef struct {
>>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>        struct lockdep_map dep_map;
>>>    #endif
>>> -} rwlock_t;
>>> +};
>>> +typedef struct rwlock rwlock_t;
>>
>> This change introduces a new globally visible "struct rwlock". Although
>> I haven't found any existing "struct rwlock" definitions, maybe it's a
>> good idea to use a more unique name instead.
> 
> This doesn't actually introduce a new globally visible "struct
> rwlock", it's already the case before.
> An inlined struct definition in a typedef is available by its struct
> name, so this is not introducing a new name
> (https://godbolt.org/z/Y1jf66e1M).

Please take another look. The godbolt example follows the pattern
"typedef struct name { ... } name_t;". The "name" part is missing from
the rwlock_t definition. This is why I wrote that the above code
introduces a new global struct name.

Bart.
