Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF13115BE
	for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557840; cv=none; b=KpAeFYRrGZjHE07bkE8zPSpPedkWCa8E2o77GR0c6oSv8ANxsa9XzeqeKEw20vB2tRArf3WttxMF4zhlk9tfhM60JdE6infIG8T330fXmP5QUl9eG3dsBSWXB9v/sQBu3csnYaxf+g25UUgvTlOc9KhX+LziomSFI4jf0NWjSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557840; c=relaxed/simple;
	bh=HdbsBw4gSw5PaJZ+M2ide4WXvlfa5tQ7NfQYHsupLII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqjCu/5IZuEKNg+QkRS3sCni4GvV4jv8bRS03D3oxDLLiRmsx2HFw4AZY3sN2SE1TS4qNJEKGQm/u2bSWte7J0k/Um1aGj+TPvbWyGf4NFXgDMW1LiwalEV65mSJSAqthzc6WK80OeuwzliZCFYPCC3eNN96xGkhnoFFcXnUUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OJ/8zG3b; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OJ/8zG3b"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fc2d92d34so6118942a12.2
        for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758557836; x=1759162636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjlCVCT1FBdo5s/V8A3PG9besuJWwpl+6YaBoT8Uymk=;
        b=OJ/8zG3byKpDS/g4w0PkC/ojyOIMf08Sqq3wDhFUkFgZMaknKyrouZyyA2kn7p/XIE
         L04IzQD402LcYQPSej677Cy4EWlBGiog5uerwBLSFatDGAvB23sCs6VjolWUbduinNIA
         tna6hZIiEZeU6qx9TABMOPL5HtZz6TMX/uNk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557836; x=1759162636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjlCVCT1FBdo5s/V8A3PG9besuJWwpl+6YaBoT8Uymk=;
        b=Jvb4gpCqnIDz23IrHxVyTWvdJEkrR2o57Pj12GJKoqBDXyXKdpNVzIhtepxgWNOo2H
         4HqiCiDiTX/QlcxCgumYHR54R70xhepVPrVQeDm19NKdIEka1UmrP/7lypggxjm4rB50
         t26rV2toFgVkHvjxD0Ge5YX1kgcAvKB36sQMpapvZUzjgP5UujfCCzsclRNfnskBOUrq
         bXDTNlY11KP74CdnbXwev4iN0iSjDiF1Yl0nmvo48UornNuMjF2MG5AGUk5FUlPQ7T1d
         z5YbgUegcgC/q9Z/CKWZpT4h6SodHb9K3WKxqO1KPRpfkzq47sNNBvNhrVxihzybXAwF
         omWA==
X-Forwarded-Encrypted: i=1; AJvYcCV9sNX+s7T7j+EW0n1weQ2Su6ckP0qFxZcrQGqXuQDHLkqMG1ELKT04n5bOcpASrFbs4Gad0GS6yIdK1C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFbCybRP67wPiTM6ous641J6QDUjAEWZZ/xfUidzwR8e7ig59
	IRClAeLmkiecZyImzaAJu6wbmf/Fecuuws7XQxlk74I2CgfOShTBou2e5cZjzOFje3pHX3jXXwM
	q2QhvRgs=
X-Gm-Gg: ASbGnctF4Vgxwiia4l9bd8sEL2r0bmf8kzpOdp3hgPh8EnLLDAFNpExI3pug37AhgDN
	i80DLmg1c7tuiVor4iqt8DP0F/Cj5vMuuojTnu63p5TyGiC6eBzUT+UohGRfFC8dZP3xnflLlYL
	DxmKQFTYmP7mUojEPWpaVfKSP8sd1XizSQEL5ujz4gdg0dQnKTBfR3kKi3liZamzxGSRJDA5xGD
	omvTqlaxfjqy9IPrT0QKk1+5T8mcIE9y6jGwKo3EMoPxsZbhdDFyH0LJLtwrLN77ux6KKlT2qWa
	r2XpxQkjQsnsWCVQYdR9ITjngImoTsaiDWH7fN8NU1A3Ru33Sxrh8HVnpPXEUF9k8PR6Gy7d+k/
	+WydFubeE4Jgkh4U35xW3w56fq2lq1rwBBz8bfRSi+CCNB+LeTE7HyJP6ewMYxlqLnaojRr0B
X-Google-Smtp-Source: AGHT+IEulnHs5F+F2+nHvlNWp1Loh3wm+1a52DAYEUd05/5dggK/VAStvFvBJXk4WmHsCJQKo1+1OQ==
X-Received: by 2002:a05:6402:23d6:b0:628:b619:49bd with SMTP id 4fb4d7f45d1cf-62fc0a90a2emr11777283a12.25.1758557835688;
        Mon, 22 Sep 2025 09:17:15 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f41594sm9179838a12.48.2025.09.22.09.17.15
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 09:17:15 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2ef8e00becso73094566b.0
        for <linux-sparse@vger.kernel.org>; Mon, 22 Sep 2025 09:17:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrW57UlohQwKoG9tRnNQSiMNxwy0j5FaMtr0QQrsH2JL1FS/JIYO/s/V7GhNYGqHHhgyMU42sf8At00KE=@vger.kernel.org
X-Received: by 2002:a17:907:1c08:b0:b04:aa9d:2240 with SMTP id
 a640c23a62f3a-b24f50a9d66mr1323244366b.39.1758557833318; Mon, 22 Sep 2025
 09:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921061337.3047616-1-mailhol@kernel.org> <CAHk-=wh2G3LxBZe-8MhNL7g+KS3BHR0z-vKFNaEeV=XQmyEwcQ@mail.gmail.com>
 <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com>
In-Reply-To: <CACePvbVYFNANx8pi9v85FHMGU3rtN4zOmnqSe-Et=s8ngh0Ltw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Sep 2025 09:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
X-Gm-Features: AS18NWBbVvc9_LxeIxz6rp7B0q5_oJ5M-Gt-M7Prq9-2iyrkinbv9ceMu2V_s1E
Message-ID: <CAHk-=wgnre70y_EFdwMbxLcd3zzihFqFrDEVed7+P7cpUU74WA@mail.gmail.com>
Subject: Re: [PATCH] Warn about "unsigned value that used to be signed against zero"
To: Chris Li <sparse@chrisli.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Sept 2025 at 05:10, Chris Li <sparse@chrisli.org> wrote:
>
> On Sun, Sep 21, 2025 at 8:16=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That's why I had added that
> >
> >         info(def->pos, "signed value source");
>
> Do you want such a line in the final patch as well? Seems worth it.

Oh, absolutely. Some of the cases it reported were really hard to
understand without it.

If it ends up being noisy, there could possibly be some heuristic like
"if the source is very close to the use that triggers it, don't bother
talking about it", but that would be a later tweak.

           Linus
