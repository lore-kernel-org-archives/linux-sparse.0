Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE3482C1
	for <linux-sparse@vger.kernel.org>; Wed, 25 Sep 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282699; cv=none; b=jg6h2s0M70SehTbPowLO0OnMu3syNC5WJrCHV3zG2fk3am26jFrTeTwE6DKdKISOL3t2uTDJy3f27sGo+9SVFYyPcqci/nHLw19WHxbxgkU6B9sDyiCAxJ7tXxIyTzX6uWYs40bbLCnM6vldyE47Nokp7EO80fQ2IMdbGX9OMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282699; c=relaxed/simple;
	bh=/t+YSp2gvbsBW9hsAIIEsn2fOHY2XQVupxHXFI22op4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iubeQPelt4ivdUzLhsegVRSKpBHiynhyMiEBZFA5nPLgrD3omPBvXFSA1juyfjzqkKjYwUvT2uV1woC4KhEUHcq6v42Bp2sqLfgJqsQARB0tC1X22QAVhxbW6gkAhKUJXmKpw1A89beJgMcJyfiNT4J3Rc+iMu2I5JEhnLZGP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=St/Bbcxr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="St/Bbcxr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3787e067230so4837835f8f.1
        for <linux-sparse@vger.kernel.org>; Wed, 25 Sep 2024 09:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727282696; x=1727887496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=St/BbcxriOuoqmhRhB6dolx2GMPnBE43J+AWtM2cjjY66UCbDLGdU7jJQXkdzkG8RB
         hK5rdYj8s5LcBrK7bJv9tEVxGDf4E5Jkot1WU0YeCAE7Jy35sNyYgs3vDgt/nE+2/rCq
         IZm/ww5GXmIQpT2kNL20DDDG8+XQxQTaLoaOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282696; x=1727887496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj8+qG2S/Bk0hHBrSluJoVQqRkgSfLVqxLrwhmmQqfQ=;
        b=JgTzFpq5rELg4NaFRTdTeb2Gg9uKIzOteYnl8jiPwmY44iz09JrSi/PpohlEfDE89q
         i4uv13FWGzhf+SyhTzTyPmwEmxfW8fMYv95ertqepLYUvp+TFcMoJCT6I6MKe8y2oLy2
         Bp0B/fN/1Kf1UdA8fXlwzUXhczpjX2aYrQkYnbadDr6Q+DlhJAHQQNSJxGnsSfyKHPym
         p9iFjc8oijOe/A/+d0PTmxc3J5ZMAiwKiUNcrnuW+yKtHEnqIqGOz6Cfxugl4gFdXkJr
         l7q2j4oe9dt7XtSxjTA1tIw6v5b4ovwIbTZXLprYGJ3DjZDtKMV7RNaBqKFuzWQwyeDw
         9tZw==
X-Forwarded-Encrypted: i=1; AJvYcCUu8FGi5YiCxaSqkURWWD19U0f8dCrQbaPKAzvc3RNoAIxpnzXgBcFnL+al40g83uUcL0KyD1rkF6kfcco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oNdwZP13B0jCs1tjMpJGA5VgCDVUeg9Ol5QgHK7ReJ91PmNk
	X59cq0/zGodqxU6rHRCOCBUgqQJeJlCvF5aRUDF5VgKgUEl9uG72eRk/XG3Rv+P8ZtnD8w7LFeY
	cfMSK1w==
X-Google-Smtp-Source: AGHT+IEot0TQfhOkMIinX561wCBQq0zKilbXxMLKpIjKHmP6Zf7wl9uUe7Bc856KoojbU1vWrawpQA==
X-Received: by 2002:adf:f30c:0:b0:374:cd36:8533 with SMTP id ffacd0b85a97d-37cc24c7347mr2440519f8f.54.1727282695867;
        Wed, 25 Sep 2024 09:44:55 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf497217sm2054028a12.31.2024.09.25.09.44.55
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:44:55 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3787e067230so4837815f8f.1
        for <linux-sparse@vger.kernel.org>; Wed, 25 Sep 2024 09:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQ0RH7CSR9WRgcEi+kV3/XdgPrhG4f86FlSt18Y4BmYm5llDcwdpK+gzIB5xybiyQ6X/98UZrZgma4Tzo=@vger.kernel.org
X-Received: by 2002:a17:906:f5a9:b0:a86:9d39:a2a with SMTP id
 a640c23a62f3a-a93a0330c37mr309689066b.8.1727282382886; Wed, 25 Sep 2024
 09:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-44-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-44-ardb+git@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 09:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Message-ID: <CAHk-=wiLYCoGSnqqPq+7fHWgmyf5DpO4SLDJ4kF=EGZVVZOX4A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/28] x86/rethook: Use RIP-relative reference for
 return address
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Wed, 25 Sept 2024 at 08:16, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> Instead of pushing an immediate absolute address, which is incompatible
> with PIE codegen or linking, use a LEA instruction to take the address
> into a register.

I don't think you can do this - it corrupts %rdi.

Yes, the code uses  %rdi later, but that's inside the SAVE_REGS_STRING
/ RESTORE_REGS_STRING area.

And we do have special calling conventions that aren't the regular
ones, so %rdi might actually be used elsewhere. For example,
__get_user_X and __put_user_X all have magical calling conventions:
they don't actually use %rdi, but part of the calling convention is
that the unused registers aren't modified.

Of course, I'm not actually sure you can probe those and trigger this
issue, but it all makes me think it's broken.

And it's entirely possible that I'm wrong for some reason, but this
just _looks_ very very wrong to me.

I think you can do this with a "pushq mem" instead, and put the
relocation into the memory location.

                 Linus
