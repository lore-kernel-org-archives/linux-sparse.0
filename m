Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D088212F05
	for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433942; cv=none; b=ChCOUR/bA03+m/3yZyb7sgykx8tk5IR8fozYr4/l+9a8Sl3ftNh0aVuhVbZDS5LLQFxlgf/ap4VkJrEZNdsYDXlwYuw7iLcD7e7ba+jRUx94LqzBWB12iU8W6h30zchfoVy4KBEUS7DZPEHv+5m9QTg9poxPB52wsq9kuuxInlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433942; c=relaxed/simple;
	bh=rF0m3RHCDCu5flwjKgaX68jhNqdc11TxTrvhrmCBPPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etuocQzxojhn8fZKvQK3jWNJIKpPrEuur32lepbSXhSdPBql/oag6u/uVywXCfZx/Y3+LVL5VdBZZQaEkIRl2aMwj5ySX+7zezvMXVrLbAmtsK8S9djGqPJmnGsJP6s0ShbTXMYmLxV9ZAAnAb5itzYEWv/zxUXOBREzMbYDn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HOwxMVfS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HOwxMVfS"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so51382487b3.1
        for <linux-sparse@vger.kernel.org>; Tue, 12 Nov 2024 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731433939; x=1732038739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4eyKsihgIZD98hfy0JGAdD/M8t7V0X38hx8vGXpfi0=;
        b=HOwxMVfSDYQ+RxVYbxIKybq63fDnnIv3ifxeI3YXFf7c7AGzMw5A621vYXjS+UFgyI
         Qp/I3I/uhNH+XQTOdmdzgHc+lCIeWwzVz0Y4VOutOEJ4vNk3L/nzxVOyjg2v7bRGV4lz
         D2HDdEGPwaAevGXkFysfNgBG2ELGQXVK2qpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433939; x=1732038739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4eyKsihgIZD98hfy0JGAdD/M8t7V0X38hx8vGXpfi0=;
        b=WkcLSHWrWXTMMotiRL2f7Q1W8ddso6yDTWTQip/RNbgphymxHBWdePyCY1IvT1+I2k
         gUKWvbLkATs5KgsZNyRcKsvMCPHZh1+zeKkbtbPkRSqm3pCsezVCuCUC3ijUJXtMRQgF
         I/rUHziJO222LUtpPGZ8OYSkq7QSZqfmeeKX0dS6pgIwFegahzfctkg7p1z02yocXwLK
         JOrJj+SEHd5B9hb3QKMBoyh5ZYp/iZG6dgI9E4rLnbIbdaH+6WN257AXurn5hd4tbEar
         AavCRJGCmvaSeXpTNyGh2JRqX8OfF4okFWb7JgCM59w+A2IlMVREg7D8uARii4JiyxMr
         8afg==
X-Forwarded-Encrypted: i=1; AJvYcCVKSQ4uOxxXPznQh9Of8NHE3lEQfVp2jnBNs5YFg6imwTiojPp7qk/GIK3+AHRvQob8tvmAzZjNhiWSGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2mDi56k2VKeoavjfdPKOwP0Idb48I1AIsVXtsbFt6BkXz/O3
	IjBfIdCbipYRUNEnoZ1qA8AQ58drTWNGIM90rb9mAiew9iE6QFrcVIoXCjANYVR94xMCKkCKUUy
	/XKRwJ46FpSSeUwNAdkpt0f0mvxpyNtWGuUkm/Q==
X-Google-Smtp-Source: AGHT+IGvEcIbEvzGr1VmCsZ0mQRwAsSPld9R2C5JTh0+fNcSwWaec7ZBqYSyzKL8e3qzWUzVn7JzLdpmgnyRZvU5CZE=
X-Received: by 2002:a05:690c:6211:b0:6ea:3313:f98c with SMTP id
 00721157ae682-6eaddf8430emr155761917b3.32.1731433939616; Tue, 12 Nov 2024
 09:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241112140454.518823-4-mailhol.vincent@wanadoo.fr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 09:52:09 -0800
Message-ID: <CAADWXX88Uv+r1JtpnN2gDv6S2wDTqxsn5x8+-U_xWfeNxmT9NA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] add _statically_true() to simplify GENMASK_INPUT_CHECK()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-sparse@vger.kernel.org, Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:05=E2=80=AFAM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> v2 -> v3:
>
>    - split the single patch into a series of two patches.

I haven't actually gotten to the patches yet, because all your emails
end up in my spam box.

The reason is because your git-send-email setup is broken, resulting in:

  dmarc=3Dfail (p=3DQUARANTINE sp=3DNONE dis=3DQUARANTINE) header.from=3Dwa=
nadoo.fr

because you claim to use a wanadoo.fr address in your "From:" line:

    From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

but you actually used gmail to send it, and the DKIM hash was
generated by gmail:

    DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3D1e100.net;

And then DMARC complains because the From: and the DKIM doesn't match.

So to actually get the right DKIM hashes, you need to either

 (a) send email using the wanadoo.fr smtp gateway

or

 (b) make the sender be that gmail address that you actually use for sendin=
g.

Pls fix.

                  Linus
