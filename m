Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD03283FEA
	for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735889; cv=none; b=idoGPQejjOU9XtB85fOR0g1IFSGLDL11Kvm4frGX71KfsU5feWK//h8295VhenHbv0/sxWQ4mCbnwRdDetofO1oGUsN0PR5RCm3zQf7YDvTM0M8YsPj7OfkEQLQhgoGnn8OWpHUXBzfhvT3PsDs4RXdgoKJ7w8OQ5G/NCQmONIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735889; c=relaxed/simple;
	bh=D4Ya3+itFal4L85Mk0yPynskH8Iivm+SbB2aLq2/F1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDWK6CHU/ftqSAppyjsHDTbrLs3Q1LonGpMGdrCUGPFBE+afwELYagM4LeqB656LY//B20LfJ+7FTvVnXBaGg4Fmns+BXZUetvaQDJZJSfDIrIaq/4QREDK2gOzA8FChXJoPoTkD5hHRFhtV15oyznMJehBrQuuMh/8R00XGgw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so88950276.1
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2025 10:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758735887; x=1759340687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4Ya3+itFal4L85Mk0yPynskH8Iivm+SbB2aLq2/F1w=;
        b=fkp/HjnUbnx8/5WLyg7BmzGws4G1H/JaIw64RZjSu7egKCKRRCUMUQWDgLR10G8III
         bep8EwsA5pwAMDOz2q72MFqdJ1MoZCk8Gceg1Z4PiOBzuFgUvbOnq96D27xIbM1kWa8L
         cQdCweJSCUNR1H3M7YoEp31EJu67NwMok6d73vmfDnmhxvLjDh/kv6R3ziYj92D49z5N
         FnDNyGZSsJpB+Afu7nKq8dMkvoABJFmF5A8H3Qs3LDLNQ4YrvSTRgI4o5FtYfi1hnXju
         b9AqlWEzHz/5XI1UkpTEfsvVMjMMDDaKIIlqjAJNh4LMbu0APIVdBqrQt71wcyI8bs6p
         Lg1w==
X-Forwarded-Encrypted: i=1; AJvYcCXutlVpD6SEe6gwwXzpHjoxJmfuNg2h8m2UwXZoKCSuTf0g/mPA0j0ctxPonjSv0d5ssHTJ0nI3IwgEN3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMB6dziEt+JSycW+c62lQtR/Kt4DyWLGqoT6v89kkaIQ5A57v
	ZhyWAKMWwpkmL0f2j8idjubprz9OmeEKWWzcAHx4zRRl7CNmNH8wsr1Z5i+VTteo7qiu3gpHHe5
	hMfwjovJmaETNc0WChvnF+OaQcmakr+Q/YWU52ALilDRuzit3AoT6Tj8=
X-Gm-Gg: ASbGncuCH8l43NPwiuqO7YS66SsjVrw4x62YkkX8wgYdBpAjn1soQjDvkstXu2JdPwY
	mvQTv//dSFUmB09CQj6t64deOrq8peUDRbYjkEZkfaAeByoZ9fRD/NhRayNtDKCvrYo6uvbIKbQ
	9CbfJKxLFwmbqiY0wKIq26manH4xqywAPGQeBeu611kO4YcPuNaAA5MjunvXdY5FvgwfxNt1+//
	zfE1q98lH5BnjTuz410d3nTiQ5iI7cvnY0ovA==
X-Google-Smtp-Source: AGHT+IG16UqrHQtSne01YysiFRYe8Zz1ZOvZwYjUGAKluzLBKeasB7SrgDW7UN+MdXOE3sGlQ1iX6TN3hB554ug3xrs=
X-Received: by 2002:a05:6902:4088:b0:ea3:cafc:3e0 with SMTP id
 3f1490d57ef6-eb37fc9b9b4mr744312276.29.1758735886665; Wed, 24 Sep 2025
 10:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org> <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
 <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com>
 <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
 <CACePvbUKV2rkYLeoQO9bWCon2qFkmKWGuh_NqvTccn=XZz7usw@mail.gmail.com> <de44070e-e71e-4935-bd59-894b6833dbc5@kernel.org>
In-Reply-To: <de44070e-e71e-4935-bd59-894b6833dbc5@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Wed, 24 Sep 2025 10:44:35 -0700
X-Gm-Features: AS18NWBbGnMp0rs2HVrwyCxjHqUtYOhhtGsE5souyWUfdNouIaSez8QdT2_ZfHM
Message-ID: <CACePvbWW0amyEDsNUhsViRwDGpzPNNXX+rQ3PC2527Uj7PJi8A@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:54=E2=80=AFAM Vincent Mailhol <mailhol@kernel.org=
> wrote:
>
>
> I think that there is a small confusion here. That line is already in the=
 patch
> inside simplify_unsigned_zero_compare(). I think that Linus was just expl=
aining
> why he added it in the original patch.

Ah, sorry for my confusion and thanks for the clarification.

It is all good then.

Chris
