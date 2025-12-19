Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AA6338595
	for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179733; cv=none; b=mBGneFJ/Z+CrzQJ1ZnV1Xay0gyWjkrU1x50EDZtdiBm5eqAZRZIRo0fe661oDJDmK78Cpi/nTbOIDfVKYsU0z6get6ugh8tuJ772m9Xsv0dSZfP4Q9lKgAjnyPMueXjON//FeFBYjwE6OWgEtM88Xh8Eo+IjF3X/MqYsjY/N3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179733; c=relaxed/simple;
	bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FC0ObD/bn5XcN7D6g7oS06NCmHlr+kt0VHZ4g9Nh1rW1otETMjkd6umTfWqHGGQRv9c50c5CIwl2Xj/Fb2YNU4eJiJ/lGbt1wTPvT4pbjuMzDwivF4E46ZLK0sjLY05kzzEbU98W6Y83fvsXri4+HBMvmcMzXAWT6M+25iak8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMtyxVaH; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMtyxVaH"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so1783303b3a.0
        for <linux-sparse@vger.kernel.org>; Fri, 19 Dec 2025 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766179731; x=1766784531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
        b=RMtyxVaHlb4x5czCBEyOx56xfjT+RNoyzgmUIOLM8rQyyjHAn8b14RHWVg+U9yECU2
         DNet9BX2LSDx+fbfhj2eagJwVgKFUN3paA/J0jVpzr17MqrPGIkC8uWMpzr25M5n/Svh
         riLL7VUKYl3lLur1iiIDnUxqZzSyVldJOlWErwA4BYTCmBjZa+IIIv/4tggBwnPyd5N1
         4sP+EomK5LaRfaouO3drpoA8BG7gNbSc2L4KFhFCx08iZDlPsih1J+3De+KvkTA6nBjx
         xSBUnB9EV5NlQAOueOI5ovsh9ZrpK2mKI2rYqZMt2HvppVyMTV6Z5xJIcetFL+mvKY9C
         JWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766179731; x=1766784531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qdyLYhk6D9KpgNEc9lTRHJNMgr66Y5zIziSEMCrXTM=;
        b=ctmQPuTIGrjHNHIobbgbAysYAbTDa5hICji5mI58cRimFT9FmRE8UZ9ONiNj3e50Pc
         Jnx0u+0nx0qX8cHu/4KQXA+QBlkIIApY7tkyDwXcP2z21MbAHXT/BnX4QY/EYeXhnudq
         H4JScO7GLR7OR3OWRFMqdzLbMPBTVJansFImrHI5ugm7fWwlt9z8LW3PxkE4Z4Rk5Z5v
         F8of96TpWIK+eFJC2fmXqcnmUAdZQL17xfXzXkzRRuuxMFimTCIWUAqVbW/475OC2ydZ
         /gV77cTOZcme8KDMi4+jqhcUyN2IZevC8tMD/InQfC4Dy3xFgxUC/HbTetk0wdXwSKKy
         UNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk5DMZzjwInx3y8gLQMR1ICBluPe2H/mcjBHlt0sYsWgcWFA2fznvgVz7wY8Z1O+aDxrSBEaJmv7W/f3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLD0XsNnSVYW9g03I6/5RhDgA6L3Q9W2VDh4yysXqzYF2wXme4
	kx2xIy4YJsYGAeQyz0NncDToNG4EwPjfRB9rBcJUKjbKJC8p1F20ijIS
X-Gm-Gg: AY/fxX5190UXT5Ij8GRKChrMOQVVKFbbSdAzz+Lk/4z9rSg3o0Gg2pysowvDymCkAwJ
	MJnL6K3cfRbbvToBkrsmhZ4nOzLXosO0VakQKUuXiCyOV8mIAOIj33+e1pReSowt/pjiPzOwDgA
	TxoYa1iePHoOV1/5RyDNBovn4rl+qkM3TXuAbHB6pHXFn+aoXs0r7Nyi+O5Utb7diWW6WP0mZrA
	73bA2VLnBGNn+7ptqlf2BAKXx9ZgP4mrfzhdG0rxRtjBGosHA67ea2kgbSdQ89HjFqlzRmhiPuI
	frLKeuokTN1Rx5R28fHq7zF4OUDFCbpotIj/xlG0URIEhR5gq2rHMjC6px6TQOSoR/amRb/UIFx
	GXCEn49oPsMu6ggH1DEUBbOcXFUpvPLgVJTNBfdaq4Zd+FVtaOH2EwdaoYuTQEec6h2QpWpWlXW
	y7S7ZIXTYhsbrHJlGI7BVCdfnqcRV/epFFz3VXG5dNVTZSRGqg27Vf4JJUGJIQIRNFnD9eCa5vg
	4w0jcRTFNmDhIrJbR2N7JGaIxezwEcFIz1mlcEL5+9jEHmbndE/cxh0huL57TebfNyw1zt2CNvj
	ih8=
X-Google-Smtp-Source: AGHT+IFntC97OMoIKW8iak4Csi+Sa/wJHZS2qz46SkDovenEuEnw3BILL/ha2LHm12T/rhrLMeYBbA==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:91ed with SMTP id a92af1059eb24-121722e01c2mr4354548c88.30.1766179731046;
        Fri, 19 Dec 2025 13:28:51 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:5874:79f3:80da:a7a3? ([2a00:79e0:2e7c:8:5874:79f3:80da:a7a3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm12305503c88.14.2025.12.19.13.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 13:28:50 -0800 (PST)
Message-ID: <ecb35204-ea13-488b-8d60-e21d4812902a@gmail.com>
Date: Fri, 19 Dec 2025 14:28:48 -0700
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/36] lockdep: Annotate lockdep assertions for context
 analysis
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
 <20251219154418.3592607-8-elver@google.com>
 <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
 <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 2:16 PM, Marco Elver wrote:
> It's basically an escape hatch to defer to dynamic analysis where the
> limits of the static analysis are reached.

That's not how lockdep_assert_held() is used in the kernel. This macro
is more often than not used to document assumptions that can be verified
at compile time.

This patch seems like a step in the wrong direction to me because it
*suppresses* compile time analysis compile-time analysis is useful. I
think that this patch either should be dropped or that the __assume()
annotations should be changed into __must_hold() annotations.

Bart.
