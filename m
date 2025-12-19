Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA032C30A
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180065; cv=none; b=j/UCcW8pE01D+LDM1Ym3bapPGpiF7YFnGOfZunQbPNgMFYNE/RJ0XwIntvz4u5ai46jFYFIdLVWcUQKkheb6vF9fknysOed9lZ/AUQnh2mj9uLLI8fiI8KCucDEO9rPFzYLjc0ujq1Emgspn5OGQLGameY0agHJb6gfejo6XpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180065; c=relaxed/simple;
	bh=nyd1g6CvIGlrKzYvOsHmwPnVPCn93E0wfS69PVJVpBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SU2YBI0fW8o5tiU0EezEd72uwqifrK69OQ+YRz8AWnrZ25kR0nDdlpZ28qJW1bbAMvxF08JUWFxFXQnDL/H0EcuEmzBRGlrpSmqxllTef82H6Z/rVONU6QW5nyQLr/YLTavj5xVy6OJbaE/4PDuPwK+mJogUrItK19o0/5wRbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRelEwD4; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRelEwD4"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1353831a12.3
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180063; x=1766784863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t32XLNtILrSHOTsv1yzEwE7SsXS6lnNnHJdt9fn7tL4=;
        b=gRelEwD4GoWlWOkPaG7BOmN8aT/9HPaC9ND1AqE2rqeR1LSEmj1uB4CPOgI2wL5rRJ
         W52vtmHxEcCK5ZC1IrQSt+k9jGxVvMAgUVGgBNBePo3Iw2kwPnrxSn0ICFyGEhlqpLk/
         7Ly56ZOn3LFbs/0GivqzTKiUjLXNInfOHUmUyIztg5z/ezsSNpeeQnD3xe9GcpJerOLj
         D/ehegZSV5Q0SBO1XajgZ2bYxvu9VhcPJXXXr42VWTOC1p79kzIkdlv7SC3Qn8XrShJQ
         7jEcSXVWh3lP3lGg91nqkOJaGDvW6VpJln9PYYRhufqtxdqJGnmlRuO05cQAuReP8LQD
         i5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180063; x=1766784863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t32XLNtILrSHOTsv1yzEwE7SsXS6lnNnHJdt9fn7tL4=;
        b=G90bmmdWOW4fuGP3P+h+WmAOKSLUI9AAz8Dn0r9O653tyAUIQh2mId76cVkyxPh63u
         CHt/PQIN7jmKNOa5wXOm6ndxD+CRnWG9anIoTvJYuwLJhE8jqZadOvoO/iqcwlhTYMNw
         Kwd2nAl4dcluq3NyQYiy72AweJeaOJUqpsdNnGh378rraWk2zsko0Q7LbPgB+nDghQNX
         d3ALoAHeyf64H1J8xz82gCyr62YLu/FfMTHkkTB2Srhw5dXwDXKYSErKwnEtFhHnBU1Z
         cBIpDWdliaUFG0i8uB4ZnnEDXZG4pHDWLXeJ7bpXZUmR48DULsL9M66Fy69/PpYTkQmf
         PWtg==
X-Forwarded-Encrypted: i=1; AJvYcCWbjR6WltXCb8UXjMZOJmIvD2u8WuoYtqiBOvbFsLcOhpL7QmjOz/gSAXzNv/CXN/skWjb28b7UvRbyA58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfktmjIy81JnhErPB/bviEYZ0lIyTyQ94P8AK5OrzaJ/pbUINF
	UiFld5/TGDEJPEnAgtr+3AVU9mqQyEvTzWsY1icprTNoiYhXM3BZDD08
X-Gm-Gg: AY/fxX7Wls/iNpMHIbxHW8BGFDQUjrNyBCx+Dq8ibegk4ACrappDpcsyOxIClLffPvl
	ecOuSXMjXKQqVkhhM46wgakkMFM8g/j7ti0/SxdNhmMS7qjqdM+RgOpQRnyQ2lct0SGm2xnb8gd
	jGzeRXmQIj+QiLaMIPJ/EKSSeTQ5hmsu68hlruZw18gLgbAAst67dCb6KXOR5s46Su+O2AtzAKK
	qTp7NaHfbUVCuY/zyPheikh0+b4/idoI72m/O2S09L5DS1Mi6prbEpnCQvfMv9mlU12AcKg+w7d
	ISoSUH9ISUn6prZgP4pNfEzhXW6NT5iHn2j8WQdBUPVDCtOBeu8hBGJTsfN81zYmvwOLPLI2UP/
	bLsSq1GySSJ6ny4KTDKltN7/+O5fQYR+eS5cFZqKVGB7xbGkDRev064gIPNUshaoO043aDbPgAa
	4jdo8wcIDDATA79DnFW66b+U97yPslrTVSyn9jzVch5yFoMDk2eNscfXuznxhGvR0A+HEchoazK
	o6aKoAo/5VUQSKhmlCk0oxxj+ssv37S5hpSoG8YtYoKJhWQLCA74Iyf2S6/PRLPw5wd0dquvyBr
	Zn8=
X-Google-Smtp-Source: AGHT+IH/ZQYDLQv8GePcj2Vm99oLZ3hFWnPTlzcp7/sSDr5k1uCEDV2wgPs8dBIcnq4Eb4hflvIUSg==
X-Received: by 2002:a05:7300:b54b:b0:2b0:57ec:d1a1 with SMTP id 5a478bee46e88-2b05ec745e9mr4652797eec.25.1766180062475;
        Fri, 19 Dec 2025 13:34:22 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm10155463eec.2.2025.12.19.13.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:34:21 -0800 (PST)
Message-ID: <0088cc8c-b395-4659-854f-a6cc5df626ed@gmail.com>
Date: Fri, 19 Dec 2025 14:34:19 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
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
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 2:02 PM, Marco Elver wrote:
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
