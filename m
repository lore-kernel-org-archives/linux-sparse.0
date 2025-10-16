Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3E334680
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634775; cv=none; b=KKmK/EbpVO6cRm1JJszbS20VRg9mO7WNrUSO106hU2cbC3oqX5EqLn6eSKvDXru6bWU76Jvuw02FwETdkqQ+IdI2g9ssqnxhKFO+h8CokGZrndr1W7QYQ9SPR4U+hhSW1WQrFpCRaTnxc3rghTgcSNHfsmhg4I4ONZvoIgHuieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634775; c=relaxed/simple;
	bh=8A7wCpXm1JqrQZTVWt5e1TOjfU9szELdGKOs9esdIBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZlcCT8zDVHyp3cicUAaow9FnUyC6ldiNolmLvdnILDcVLU0pqGra1QSXMVqHjC/MNRkkmvJHErntIpjAsmQ2ZmfKFKDQxx3eR71f3ylqPXEiX+7IGyyRqJUujA56cDcJ0B77AaGma00xvkrfb3grWSxfRfOxEXjzqa91Z7/ZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GZWZmODQ; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZWZmODQ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-633be3be1e6so1595763d50.1
        for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760634772; x=1761239572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEY5Cy32ywjnG1KYtsZ69zGjm5flZHjdxa1tdX4atCo=;
        b=GZWZmODQilZplvjlDNNhWqYtFQEvQNDXf6uSqRSNskuSqejOP+eDhQ4X/gWeYG13j3
         zp/3+NkqQ405DgY7jljvaP1bGjGsakqjZAIa6eXMTVtJgDVl+qc9UwJPnujNbSINZHTn
         zb1f5bCGYMQP9IvwIg3LxjmppJaaMCxWgl4yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760634772; x=1761239572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEY5Cy32ywjnG1KYtsZ69zGjm5flZHjdxa1tdX4atCo=;
        b=OG2mW2AcyKUqMZgW7uHANgHbYj5loxXeYWcEjJXhSgzCW1uBVzm+U4ALtFVUxaOWoo
         zyrcZqd8UdADcNgIOv/SiC/d6xvutZyWU42LZCRXISzjMMP8mEI7eTewxWEkYZjON/HF
         Iyq2S0ZKc9mKJD/UJaB74DVje6o2olZvAcE0unejRGiy36w9r7B5CZi4jBnuqTMSiXdM
         /vY25OVzCN3PBYW0GB6mjss/jXNGS4TnXwSRV/4rgNsIl9j/V5iyXe8dNV0CwUk+Z8sb
         FBSvMw7tK5k7TxrxiLMFTYRKBlDAXGeVk72p6cxFuvJ98dkPJvNoPT0sXIasAqO3iQYL
         Powg==
X-Gm-Message-State: AOJu0YzTXX3Kk+kPOq4Fw0+yEhbnrPkn4uXeYutr9MrkLdEWTzSj5DYp
	578TEyG+P+d629Ti7t71wkxpE21kYaddIZ0dJyajJHRSJD1Wcoby3+358IjDWes/oU50vRjPiYL
	8Rd0MuCNNXtkW8AR7RGV1uB8U31PIHieWhli+G+Hdfw==
X-Gm-Gg: ASbGnctivlnBggV8ucBcy6P5Jjv2GDJvS9kLq9mcLoh0B1wIFjELANJKdZ1ykMdA7Vi
	OnFC0zeK2XV6zpsA/Id6IzNwdgIFAnCtAbmiIdc0csBmkyALEOswXp04arXKCopt2OP2SeyN6MJ
	w/OlpVVeuKMRD0ebTlS6EIBtM8nmMHHat1CDT3QdGSQG4xVnOFSG8vMcIsFiCQCf4W8gjISeMSu
	OE9Kqte+UpDr5vPaNgDGHD3/aftTMrnF+SXqRQC5/V6Cwz6cQjuG+Ne7Spl
X-Google-Smtp-Source: AGHT+IHIVChKRIlE1k1ZiXM3xSKosZMb8JmwlvyNDeWwwrUbPzRan5wkOh+PiDmRNET3cvprFeHkRihy0QFAu6MUr/8=
X-Received: by 2002:a05:690e:1591:10b0:629:3bfd:99aa with SMTP id
 956f58d0204a3-63e08e4d99cmr88152d50.11.1760634772114; Thu, 16 Oct 2025
 10:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Oct 2025 10:12:40 -0700
X-Gm-Features: AS18NWAz2bwux6Q667g3J8LAZWoJBUPF3Xlkv6jef8W4SkqfQ7kQdYQN9vsGDiY
Message-ID: <CAADWXX_kGbSjXrt9ZQGLg7R_ioEnqvZ_s+asrPAPgNnQ_LbaBQ@mail.gmail.com>
Subject: Re: Add printf/scanf -Wformat checking
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:04=E2=80=AFAM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> [re-send as I can't type sparse and messages didn't get to the list]

You may need to re-send again after fixing your mailer setup, because
while it made it to the list, I suspect a lot of people didn't
actually get it, because it fails DKIM checks and that then tends to
mean that it gets marked as spam.

At least it did for me - but I check my spam folder daily, so I noticed.

The reason it fails DKIM is that your codethink DKIM setup is scrogged.

The DKIM message headers look like this:

  DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxed;
d=3Dcodethink.co.uk; s=3Dimap4-20230908;

so far, all good. You have DKIM, it uses relaxed/relaxed, all great.
But then it continues with the list of headers that are hashed:

  h=3DSender:Content-Transfer-Encoding:
MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:

All still good so far, and those are the right headers. But they are
pretty much the *only* right headers, because the list of headers then
goes on with

     Content-Type:
Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive=
;

and that's just bogus.

Having email list headers in the DKIM header hashing means that any
well-behaved mailing list that adds its own subscription headers will
now result in a different hash, and DKIM will fail, and anybody who
reads the list with a sane MUA will not see the emails you sent.

So by all means keep the "In-Reply-To" and "References" headers in the
DKIM list, but get rid of all the "List-Help" etc headers, because
they are actively wrong and bad.

I've seen this before, and I have been told that there's some Debian
DKIM help page for DKIM that lists those headers. I don't know the
details, but that help page is really actively wrong and should be
fixed.

Typically, you should really only list the headers you really care
about: things that *matter*. Things that make it clear that it was
from you, and what the subject and thread was.

Other headers shouldn't be hashed, exactly because there are valid
reasons why those headers may then be added by intermediate mailers).

Anyway, what this results in is that when I look at the headers, I see this=
:

  ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org;
dmarc=3Dpass (p=3Dreject dis=3Dnone) header.from=3Dcodethink.co.uk; spf=3Dp=
ass
smtp.mailfrom=3Dcodethink.com; dkim=3Dpass (2048-bit key)
header.d=3Dcodethink.co.uk header.i=3D@codethink.co.uk header.b=3Dx51xpGj+;
arc=3Dnone smtp.client-ip=3D188.40.203.114
  Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass
(p=3Dreject dis=3Dnone) header.from=3Dcodethink.co.uk

ie the list receiver is happy, because at the time the list gets the
email directly from you, the DKIM hash matches, and so DMARC rules at
that time say "all good".

But then when the list re-sends the email out to list subscribers,
they will get something like this:

  Authentication-Results: mx.google.com;
       dkim=3Dfail header.i=3D@codethink.co.uk header.s=3Dimap4-20230908
header.b=3Dx51xpGj+;

because the list expander has added headers

  List-Id: <linux-sparse.vger.kernel.org>
  List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
  List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>

(and possibly others) so now the header hash no longer matches,
because you've told dkim to hash those headers. They obviously weren't
there in your original email, so now the hash that codethink computed
is no longer matching the headers that the list sends out.

And this is a well-behaved mailing list that does what mailing lists
*should* do, in adding those headers. It's really your DKIM that is
actively wrong.

If you remember where you got the bad list of headers from, maybe you
can report this problem upstream too?

              Linus
