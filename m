Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8461BD9D2
	for <linux-sparse@vger.kernel.org>; Mon, 18 Nov 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949817; cv=none; b=h4W/3Vx49S7BOaa3meHCvgI8UlQloFP+tkGnumbdBgzLfNtKfwyvS3IX3c4k9sJqNSYE9jhcQJ/YoA8yN+CFWhc3NZbYcsSFTpoQwUf2rEJ3SMFya+lCzFVzQAHQxmwlpLYwIQHo/IubHMrMYpXSHxSTq2M50Mhy8ojuXdpU8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949817; c=relaxed/simple;
	bh=W0Jl5ocHSP4PGYw8LxtnuPw3akkRY4E9C/tdE6Gbf2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtFxlg27vVbFfegT2GWt7hUhK+HXj8TzXU8i/Ahv64Bkt8QC1tUFfgn4EorRfyosouJ8QH013p6gKrdWVOwlfjBq0AMjFKcs+0XgF017QntLiF2ziWexYwjKJ1EAb0+u623kY95bjPGt/5YcqgQuTwiER1DqYDgi06cwgoZzgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iNG5vNci; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iNG5vNci"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso1865786a12.3
        for <linux-sparse@vger.kernel.org>; Mon, 18 Nov 2024 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731949813; x=1732554613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHhSpMFQSzvTkKEefPe2mtAUvRV1u6SYwiNS6wbH29c=;
        b=iNG5vNciWnZuo40+8zsdGU6zhGHAZGz3dyl7X482LRMdFv2GmvVQLi9JPlutL/z++D
         jWA3lOfSc4I/aGYuH/QbuuFaojUazbRlRe7MB52kfB7/cBFObRjLR22W9c+lF+c1CfPj
         gjmPIer5IL6a+axphpoA2g9xb8PMjQ9nsAfF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949813; x=1732554613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHhSpMFQSzvTkKEefPe2mtAUvRV1u6SYwiNS6wbH29c=;
        b=IQYfCnZbMz+vYGN6onPboTTK1cbKtznoofKstoDekJxdhmO8UomhmC4eyNvthmloKe
         D6z2NMMd/nEfIFST4eOGVSFW3FAfbbdcC0bw3ey3ojZReTdKxcwcIpodGcT4S8Ol7iyz
         W/VaBQGx6iYrjxNgVv+8Bq9d/PJCgchYg3OiYgeFSlX2iPRj4dZZrNruXbAkFNTa7qQo
         yACBO13Qp7RBSnGLOdOECwuRvYWN7kZG+O+47hvl81WBTLCzb5wdRWPahA+nIp+4UHZE
         gT/A4dfJCHCRGRt6LqHTaUkdnWA/jh6QM9XOX4Htk+BxeP+bFxe9CDesy02OueTECvSU
         EIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpTtDFwXb08czWBJKW27MnIJGJTh0mtUyCTg558MY4RalayMNzMP2KmwjZFwNg6lXQvX86BCXcmmmOSok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXDPbpDfwCfHWRl7WvVux70Lp3LnxrhJl0/T2MzaIDszS3k8j
	QlDRGj2p8zdgEV1QSCZaS8GJyvKTAHTfLmHvWLoHVWCUTBUpAk8f9R8LOggIr044QVZ9RKPE6Yp
	nEKit9w==
X-Google-Smtp-Source: AGHT+IGaYZSG4zZd4mTS/wJo3Y4pZr/oYDooCNdd4ohRhHZIRP5RKHzPzzPmsvOpJI0qF4JF2s5+7A==
X-Received: by 2002:a17:907:2d91:b0:a99:f8db:68b2 with SMTP id a640c23a62f3a-aa483421ca0mr1154354766b.18.1731949812889;
        Mon, 18 Nov 2024 09:10:12 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0016b3sm566804266b.103.2024.11.18.09.10.12
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 09:10:12 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so6966b.3
        for <linux-sparse@vger.kernel.org>; Mon, 18 Nov 2024 09:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkbCQ330ej8VYCxJ51CAy5KF8Rwxwv7+Cb+aGZPRg685+zFNumFZj7dPCLLeJ/kUGfgqGCKqz+R+oTbYw=@vger.kernel.org
X-Received: by 2002:a17:907:2d91:b0:a99:f8db:68b2 with SMTP id
 a640c23a62f3a-aa483421ca0mr1154348466b.18.1731949811840; Mon, 18 Nov 2024
 09:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com> <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com> <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
 <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ=ze66FuOrWvuY26T6p+9GftrAeVApbTLnT_HgRWJL_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 09:09:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0r4XutgSRxzeEi6QQUJ4oej5o-kdS8j02KrLEXT4WnA@mail.gmail.com>
Message-ID: <CAHk-=wg0r4XutgSRxzeEi6QQUJ4oej5o-kdS8j02KrLEXT4WnA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David Laight <David.Laight@aculab.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 19:22, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> I did a tree wide replacement of __is_constexpr() with is_const() and
> did an allyesconfig build test. It yields a -Wint-in-bool-context
> warning in GCC for both the "0*!(x)" and the "0&&(x)" each time the
> expression contains non-boolean operators, for example: * or <<.

Grr. Annoying. But yeah, replace the "!" with "!= 0" and I guess it
should be ok.

             Linus
