Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837011D54B
	for <linux-sparse@vger.kernel.org>; Wed, 12 Jun 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197510; cv=none; b=ahNR8mR6NJ6wY7pwMGw4SwWeRomkwtddL3kly7e1UOdKFNCjUN8JVmBxDo0RblA6KxH3B/bdLq/jfjpmkMF2vQm2U165YzcMEgT8NeiByOd+Kunab4mbxkx3OtvpZVHLD1F9OcezMQe3sea59AsZZleyCbzGnOFm+31FDG9rWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197510; c=relaxed/simple;
	bh=fnueGGgC0JWoLl9jMKeB3p+gamNqEpAW0LyuK1BUG5c=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nXscn2n6IlSfNWJNDAwODPIUini6iiHyjQ+1hdMvN7R5KeE+kPU5FiZDGzbzwjReFKIk0MyxSwHebgq5TGTfW4NpjwCwcClTXd/S/8UR1tGf+rcCueWCqgq37A3HRJ32j4iL2TX0wPiPElZDlTt250Y3ZTkMJu2YlhFnunsjP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUM+brmQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUM+brmQ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso698246566b.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jun 2024 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197506; x=1718802306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ysrZ9DHs7VwMnODwyqYFMtp/QwSElT5e0I6EeQYSTHk=;
        b=jUM+brmQOXB5qKH/gz87Hx3fs71uDsF/agwauAlWx+mLWkzUzSHVG0uQLqwBL2buXR
         PkyJLocYkbWl4WoVWe29PCHYduTyXUE3NHKRCWqYsaL5Be3mdSQbVulu0C8AD0oqURa6
         TT2r/K5VXPJA8rN8AVbQDun9VCvZjEtb9BaPVvWmvheUWEjl/KW7YNTe4Na+mTFQaH8B
         UeXhdMEiU4KdlF3Klr5owrnI70jxeO1JgcChx8FLoZ0bqgStdtuIUVi4KzwyI0vDY0HC
         +4KrqZWKJ+KNiDnmFRgODwL9/MJ2g8cjeS4QKqIVfdjpEhTmEe8YMU42mPLVjtCjX1EN
         ui0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197506; x=1718802306;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysrZ9DHs7VwMnODwyqYFMtp/QwSElT5e0I6EeQYSTHk=;
        b=eGvE5ZEn8YDTdzovSYSPh0Lneh6jeDn7lXI99uVTjSStjXlcfSq3Vyspw7vPJKJwWl
         kyuNyc/pSKi3Z3wIb5/AVR1QCLGrovduuNT8XZpcmzZd3LM2nfDcRqsjLGE1/zVJnc+S
         fT4AuuZULtTEsNlbSlBSry+eyGd3hlz71Q31OqmuAWFYypAyK1BtZIBLQTzfmKTsrkWA
         K/sr92FgmqlBjV4WS4OYO5nuy1MFO9Tm7Z0gThLRus+VYat9PRg4VV4CUIIV94eyHXQy
         L8W++gIYFWEGc26xwrX+r7QAYIBX4mFvMKf30lfii4U6Zhk7y9ndMvBW1mpnHH3PVDKn
         3WaA==
X-Gm-Message-State: AOJu0Yxz1KE2M2FhyJdFY82g3m1K094F45ymLIY8kKh9zFiw/APQOysN
	Zyl2lcFjeqbV234SkRxt1p2hkcrTN8tpPc31A+0eHH9cuhxS9QNRrPl/8s50Nes=
X-Google-Smtp-Source: AGHT+IFHWYzYSDbmyVjD0wJ81RfIuhK/Wx8XLhEbME939LekcU22ecI5wa++zVJuYEaFwtyUbTJlNA==
X-Received: by 2002:a17:907:728e:b0:a6e:f7ee:b1fa with SMTP id a640c23a62f3a-a6f48009f7dmr115688966b.72.1718197505954;
        Wed, 12 Jun 2024 06:05:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f266884c5sm325714366b.29.2024.06.12.06.05.05
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:05:05 -0700 (PDT)
Message-ID: <c8064d5fee508ea1792d1fc818c9da78fcb0bdf4.camel@gmail.com>
Subject: sparse with llvm
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: linux-sparse@vger.kernel.org
Date: Wed, 12 Jun 2024 15:08:53 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

Likely this is a dumb question but is it possible at all to run sparse on t=
he
linux kernel when compiled with LLVM=3D1?

So running

make C=3D2 LLVM=3D1 ARCH=3Darm file_to_check

gives me this:

  CHECK   scripts/mod/empty.c
No such file: gnu


Should the above work at all?

Thanks!
- Nuno S=C3=A1?
