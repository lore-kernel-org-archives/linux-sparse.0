Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756181DA619
	for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731870192; cv=none; b=s+fgTTut9QaDDXJPXhv4SzlrPUp4LqgrHxpKoQtZrQCchNjs5Zs6LmAVa58RJUfWwXHfrbE5SkXHyZr2Ar6Q8i3eFZxxR/Ry+aA+992wdEIWfOU9Js7IaQ55UGqMSRdIQ57SIwBAuEy6RmL2L5ow0IvOTY/UvuDe3ovKxZQB4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731870192; c=relaxed/simple;
	bh=PbCBqaJHyFRDMeonXV3O7iZF9Acjc/0jknvwxclpPpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsF8onf95AKSdfRG9GK6JNqKz8atw5HCiTfYrd6jgOrtevrDDP+FFP5dKB9/yVJJ04sg1hb/XULB94ldDG6HVBDoTz5uhTHfeiUR5vYUN1DL5ZHZmjW4cBoDuN7AA6uEtQL9S3OboX+xFAf50s4gn3k10L0ecTdWwTg9b/UyfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OhvIyrn2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OhvIyrn2"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so607594866b.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731870189; x=1732474989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpvG0qQDXuWwD4N53pblBbRWNlYroopV0zVsAjj1jLo=;
        b=OhvIyrn2K9t0uBsiTG/FwYaxa8jH9qADRMGlZya4MqaY/n6nmYJlOAXrlIAQPEQgni
         zPYA3mxjzSagKPeiE6MX0/BKhX5Lu1CJsqW8WLvggu2++3gtNQ0r3lzmknJatKOa88MS
         oDJtWyECmYw3kTsLvIAMsUgKbP7K4Hd8/ViJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731870189; x=1732474989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpvG0qQDXuWwD4N53pblBbRWNlYroopV0zVsAjj1jLo=;
        b=XUJUXv2DzTgOY77rsPYrvpkoC7haubhM2+3QICJbYavU0eq91GTmWFDjbTUJHn/hpS
         /Y+2BWDprxWnKnrE0zmWOqSNQ4HNY8/SRQtPxH1usZ3khfguUDK4nQOZ+udl7MvlsKEF
         +m3I9EzcHYJsVVwbCtrsesCrkVDcvvCPbXiC89XmbJVgvgiEyCBsMdkIaLZMRhmcPoaO
         te/4ETaIw18QL+8aKzfU3DnwZyAzZ/1hycMESAgYQPLPbS7wJJ83GwY+ItdFE0ZY/59w
         Ceg+c/pDEcjSM43Ln6AkrGB/nTQ+Hsk98KBXYw6LNQn1G6Y5e3ACA6YI3J1c1w6W9pYN
         RLag==
X-Forwarded-Encrypted: i=1; AJvYcCV61ucQx6nn6JrWBcj0kJsmT1OBebn6rEJJiSjVV5PxWhVcia+lxP4uVTySXamOpr35NzCpJPTu9waS0UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQF/YXW7EOGA5HowQra3oI0Ro7YyDiCFPMX1W5wGggjRDJMGv
	Rj6ut1amJkSeUjPxRQFvRqlPm6UL5DK6J6rtDevvqx1cvy9ItWnQ+FutV14e0MPT6cpBCq2dVTc
	iKXsrVw==
X-Google-Smtp-Source: AGHT+IEV3FOnp+fXbXHSsQvD8UCz7BOiFLeHCDypbSFESDZhpSWhMq0ngrROUf7R8AoG6+K4puthug==
X-Received: by 2002:a17:907:25ce:b0:a9a:6855:1820 with SMTP id a640c23a62f3a-aa48340a6f0mr992268866b.15.1731870188642;
        Sun, 17 Nov 2024 11:03:08 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5038asm440237566b.45.2024.11.17.11.03.07
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 11:03:07 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso777693a12.3
        for <linux-sparse@vger.kernel.org>; Sun, 17 Nov 2024 11:03:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpBYsHcES/YziZ0IzuZETaTlHyYHDcGn8Ew6pStIJQDvDNNCo55dfYlPsLGU7k86C4dWRlc70hTHkn1pw=@vger.kernel.org
X-Received: by 2002:a17:907:809:b0:a99:5021:bcf0 with SMTP id
 a640c23a62f3a-aa483454541mr826309666b.34.1731870186621; Sun, 17 Nov 2024
 11:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
In-Reply-To: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 11:02:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whVDzempHTWHMRpbSdCpFhSyfcLyfx2XvSTZNT-MNSS0A@mail.gmail.com>
Message-ID: <CAHk-=whVDzempHTWHMRpbSdCpFhSyfcLyfx2XvSTZNT-MNSS0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 10:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, something like this:
>
>    /*
>     * iff 'x' is a non-zero constant integer expression,
>     * then '!(x)' will be a zero constant integer expression,
>     * and casting that to 'void *' will result in a NULL
>     * pointer. Otherwise casting it to 'void *' will be just
>     * a regular 'void *'.
>     *
>     * The type of '0 ? NULL : (char *)' is 'char *'
>     * The type of '0 ? (void *) : (char *) is 'void *'
>     */
>     #define const_true(x) \
>         _Generic(0 ? (void *)((long)!(x)) : (char *)0, char *: 1, void *: 0)
>
> should work, and doesn't do any double expansion of complex arguments.

Always good to test things, and it does seem to actually work.

Interestingly, while testing it, I found what looks like a (harmless)
bug in gcc.

Gcc seems to think that "!(void *)1" is an integer constant expression.

But technically, only *integer* casts can be part of an integer
constant expression.

Both sparse and clang get that odd case right.

Practically speaking, this doesn't matter, but I'll claim that my test
coverage was at least interesting since it seems to have found a
compiler issue.

Maybe it's a documented gcc thing, I'm not sure. Regardless, I think I
actually prefer the gcc behavior, but I don't see that it really makes
much of a difference.

               Linus
