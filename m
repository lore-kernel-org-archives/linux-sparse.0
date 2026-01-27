Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FD299A81
	for <linux-sparse@vger.kernel.org>; Tue, 27 Jan 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509087; cv=pass; b=j5S1UafvLJZSTrdaVIkBg2Tc3GoMNtGoYZtNN+h5inemEsZEgJGjc7lJ8rBM3lRsPIZWyum27ipNih0mjT7vBRk5UyRKSA0IX4FjsHaJYYVmFzQdbR3Lwwhd5hxuJ5OnrcrjybTIwW1WiuPEMhQ7+A/W2ye4uObhQ/jOpoKd0no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509087; c=relaxed/simple;
	bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPDqQ+ROpjASTLaLpLnCh9eI3bKCYqo9WpWL3Q1FvqoRA86xeX8Qs/6CGFuuwfrsY+BPkXN82IIUbK4o9DgyI1q9k/nTr85ki6kr8/Ozo6xHAh8AUgt4R9gwyv4xhZOsPdhiFdNnt9FRTD+0kelDVSTtOzFWI8OWNEa6QzOolcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CBOsHD/; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CBOsHD/"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12332910300so2129456c88.0
        for <linux-sparse@vger.kernel.org>; Tue, 27 Jan 2026 02:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769509082; cv=none;
        d=google.com; s=arc-20240605;
        b=AWnKYaRT2O4pLQYz4yyc2PInGlTzcvvvmX/KJ90gwhnpQxZ+bq/MsxrmKuGklnzRUf
         JNsG7VpT/FnVd1EeDbUPeIuhKyA4VonwSBeRhABCmoRYSpu6aGPv6nAUs+o3YRfnv4kj
         hxEqQ5HN0UYHEtXPlE31Z4xv4Y/gVfQTHNCUd6qh5iuZZkHfyLRKQmnmm8971+rleEBT
         cazv4RhdZPHDYP1PtbBV8mM1bsGkZVNUUUH4X2fQ//NUgtveLQnQbRQl1uke6KqHyy51
         XvAIGBmk3BC5X/atOs1FraHHSA8ikB3hfKpg6yZ7VLcwGXVcD0am4K8RkmUDRptz9/WF
         Zfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        fh=Clo9OlEQ9xP4gXlEivhwp5QjIcQWq+LMsYshjOwN3vI=;
        b=dBXVmwspCI6PMs4OAXRTEW845BVGCVgvFUIpphfunE5s4L6VcEj0m2/gQ0/XG3vhfE
         Z6LbuD5RfKxpupcDMdgFPwpVwRp7Id2dp5GSdBkVmFwTzI5ukHdvIfENXlLCNs50EG3Y
         OQkuKkiamWoIp1oOzjGbAHVc6Muvr4GUCC/X4LZwcBQwVdMpIVyn8lL9LXxsaQL9kWL3
         vwnCH6Chf4lGtZDDQ3NLLbGHALZqQ1rLYVXCk1UfyBMx1I2DH7jTJKb2R+iFQutLXCg6
         zgwNyKhWYOkdZuF6mza+aUGhO/h1kRDHFaQER8XvwOqfI5s0LFlpjwUTGpYNIcFL1z2o
         75OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769509082; x=1770113882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=0CBOsHD/uKOv95aR8OTAbtRyWBxyLJ6N1fESKzC2veqVx9JPRAR/Gsg+n8VRUW2Hp3
         EG6v3t7dFFHmx4Qe9/enHqvAYc/MN+zbW34Q0dIEP/dBnHyBwmTXLN/s4AgkzfrYowyK
         TS9/3JGwU153BB0kkOIvZ5Xtjd+Bp8Z4TnxiAJfhMEvuCB4na3T6n77gyhHa/UDpEb0b
         IgALtOGmCw2o5+TNyDxryyFP5U2h1On49wPhmsdnKC83ra3MXi1Xx96djhullUZFhEEf
         Bu8bIyKcXqPDpnJ079sq0S/S0xkr66rrSYp7sxWe3EDfxUs2fpKiC1ykKYevzeLX0nO4
         YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509082; x=1770113882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=qYmwX0UTIw/qQzS6AJbN6952YF2YkzEPTrxJhM6Zj0TdxCpl/v9fe5FB9zysK2J4FJ
         2mboS5ci78m/7A10216Q5tEQvUyV8eFDaHSChqyciS1Z1+FxkhR9XXb+RMOMkUCXm13H
         99nR4m0muX8LYPcQ/BeLm/vFRMh0/jDHWxoN29l2nmv52X7pIjWtyHzC+b1v9VEkchzU
         y81O00jF1c+ROOMqromOc5TT/8j0XL6h55FszSWB1sJuCX46y8r8PxfE/2HN4N7ZwZFb
         5v+8y4kUh6aifeoX0baYmZ6i5r29sB4GFDtQExdlALHaSaCVxqV6RJAmoRoVMOUxGm/L
         dv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYBvIeJz1qgPDzT+CKi4QovU5qlhPolx4Hfz6Y+nmxBbMQD5A/NsnS3mJKelK9sQAm3uxhjnccTEvJBtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkjSQDilGNSWy4tM4ARJlBkYC8oFh0IWD9+qCXj1MtB2rGP0B
	DeTswbdlJmeIB307ommh+ol+Oizco12tDapc1LdwIPsRvmYyapybnxG2zj+lz7rFJLwb06Z3MIR
	9QKOHpD5+aLekXQE5HwP7O5efpGxucduhiPPL5umj
X-Gm-Gg: AZuq6aIZtkihaXnsAjC1Oepnc1VPBb6b7BXa21JSYxA0A80oHtOFl893ceF38/AXVts
	N204nyg37mGz8QqkX07kgXMmdRa4YT+gvVIkOfLjOligTo16o9hEpM6klE4zym5fXlwsd7xX/oT
	Q+1J7yCXy/9bo5GaHBq6KSUUa1amfLQ7wNRMk8onMsgWTV+sN+k1AcRrQYnljFWIrf+LY02onnz
	rvV79atk8hi048Y4ddEvx2KCGjxhKE2akBIBjpRZ33hlcz7DtptzFHYXht3U/iwDZ0E0hFqm4/a
	y3TLeD4BTIXmr9jt0erFdIgcpw==
X-Received: by 2002:a05:7022:6985:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-124a00cd55dmr806676c88.36.1769509081547; Tue, 27 Jan 2026
 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-7-elver@google.com>
 <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
In-Reply-To: <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 11:17:24 +0100
X-Gm-Features: AZwV_Qj2UVNnjgQTvKRMxq0N2rMz8K4yMXQyPWTkZbJrWul7iRYbem2vd2u4cZs
Message-ID: <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context analysis
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:14, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Sid for awareness
>
> Hi,
>
> This patch breaks the radix tree and VMA userland tests. The next bots didn't
> catch it but it seems now they're building the userland VMA tests
> (e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
> not caught up to the issue this one caused (fails build in tools/testing/vma and
> tools/testing/radix-tree).
>
> Anyway it's a really easy fix, just need to stub out __no_context_analysis in
> the tools/include copy of compiler_types.h, fix-patch provided below.
>
> To avoid bisection hazard it'd be nice if it could be folded into this series
> before this patch, but if we're too late in the cycle for that I can submit a
> fix separately.

Thanks, I saw. I have a more complete fix I'm about to send.
