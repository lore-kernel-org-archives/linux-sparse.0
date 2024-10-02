Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC861D0E28
	for <linux-sparse@vger.kernel.org>; Wed,  2 Oct 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899820; cv=none; b=TMWOhk7pLGFQEYwScdDvkTperzTuGczV/nT+KFz4JQHmxMVSyR19pnnG+njiWsBjfr08clXP/tBIp5mBI8MUMS2wrGIHi0hK8MBV7w/G4y6MIAVpXMRe7kcy0pZ01U5PREcnK5FcMCYWvIcyndR1nRMugn6DN54RU46ygVU2MtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899820; c=relaxed/simple;
	bh=26ch3VLdZlgASzApmc+sdmN42sQrSbzi8ri/yXB2hcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T25XVT/0tKrziymGu/gwHXOi/+0KBqkHXX1/QUOFfB+G3LoFYSi+u6iKrIeCelOl1VJDoCGSfKvCb0rkX3iRIb8i032qLyECshrfHLuBEB2TyMOiXAergWni4qE2RrOaMbFvrbf+n9/y71lnMlDgJyTqqnmYXHiDGqf39TngJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BjTNk6yl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BjTNk6yl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83562f9be9so13788566b.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Oct 2024 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727899817; x=1728504617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=BjTNk6ylw4QeddB8tq2zCNU6ld6TF6r/G4YSJq6K3/5t72wQiJ+kIbfNKpx6sV5SKn
         Tp7m98gmlutA/vXpgufKz6hP64YDlNeMMh0QbF3MBwwuVB28SOOnfb/gMnQVMVp2t6/e
         xtDuT+/aYpwhmyc2yVwU8pO7TyR+9BKhsNpq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899817; x=1728504617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=felyUMZ1epn3qYN0qQZjWDzIrXK7nsXRUmOCiXehfgQ=;
        b=M8Tks78pS7bIEkAKxZvXliEDYXVlfYCYAX6EUreQCKCnZxOkLVKxlApwPVnkWaNor1
         uF6wQ6jtP8Fqio0zG2AKYiOr3pKpP5sLVCknDaxSzFEovFJVcvEi6mWl65Gq2b08NutA
         s6ykHZWzdn1xf5zohnnXzP8uRYqMGUYyqCxl7Yc6Ptp5GktYaRrGhYvAaLOqzDJ3jtez
         IeOsjcx6MS3tZ4e/PlNwT7JjPeZTtdeLDY6v/fs7aXomH3co/nz1RZ+X/hFZpiqqoExq
         B/+QNdDhM0j1r4AwOUUH4iSPaIHVCn/mDnWuWT5rb/e3FzysAi55M9zSttiAby2k8H4x
         Hl7w==
X-Forwarded-Encrypted: i=1; AJvYcCVq7Ei9w+/NS6rNXGZlrsBhlbGPUQ0Q0bajrOgnCADQ9LEbYwCTY7WxkbtFeVI+EM7k8LEPVPwChgD5frA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gcKUviQUpGhRFyHp9vLy8rY0Nzmk1nmN4Q0LAnzaahJpgPHK
	XoDZSrB2F3ctDvbgSSopJWgv0KNl+RF1it4X7ISfBv+LR00KML8LQrm+or5PJR5U0ii7dcXakcS
	/m9mKgA==
X-Google-Smtp-Source: AGHT+IFpYGKf0eXPCu0x44+HdlQLuNf1ah5QNp/o0GTubU3y8MBjN0jMTP/JhQfg/sAYnj9LZ7v/1w==
X-Received: by 2002:a17:907:7e8a:b0:a91:15ba:9013 with SMTP id a640c23a62f3a-a98f820796emr356225966b.9.1727899816991;
        Wed, 02 Oct 2024 13:10:16 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5ad4sm910302966b.68.2024.10.02.13.10.16
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:10:16 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ccfbbd467so152818f8f.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Oct 2024 13:10:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbmY18M87GtMO6QGFQv+NwqmYkMRb4hZkQ3RzpJ4eWwIcrU+vaVOYleXmOyizME+NPP1zhy4pKY2Awqd8=@vger.kernel.org
X-Received: by 2002:a05:6512:e9e:b0:535:6795:301a with SMTP id
 2adb3069b0e04-539a079eb59mr2506573e87.47.1727899328912; Wed, 02 Oct 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
In-Reply-To: <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 13:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Message-ID: <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 08:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> I guess you are referring to the use of a GOT? That is a valid
> concern, but it does not apply here. With hidden visibility and
> compiler command line options like -mdirect-access-extern, all emitted
> symbol references are direct.

I absolutely hate GOT entries. We definitely shouldn't ever do
anything that causes them on x86-64.

I'd much rather just do boot-time relocation, and I don't think the
"we run code at a different location than we told the linker" is an
arghument against it.

Please, let's make sure we never have any of the global offset table horror.

Yes, yes, you can't avoid them on other architectures.

That said, doing changes like changing "mov $sym" to "lea sym(%rip)" I
feel are a complete no-brainer and should be done regardless of any
other code generation issues.

Let's not do relocation for no good reason.

             Linus
