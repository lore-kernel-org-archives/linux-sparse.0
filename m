Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA164436A
	for <linux-sparse@vger.kernel.org>; Tue, 13 Aug 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530841; cv=none; b=qadgY/VeXxacBSHpONS3/H2otTYyrs5Tm/V4NZq98luWFua5rZ0N3osawXKCP0lJIkYTkYxANvGYkbcUp6C36L83xGxDpgpXLhMmE3pe1LcDYWadJN6AoUQVUP+wd5JI0dJMy6OgIiq3DDcTeHcNWFbiIKewAxGDqpbijJbp8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530841; c=relaxed/simple;
	bh=lq9zdQwq9QYoXi3kNAzMmIxc74ryyJ2h1pSyE5ATEtw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Fz6mC9SfdJvvigSns8i6LyVqBkWWJsfehZSDnNGO/WoHoseCTV6UFoeHMDt/+mwhXfAAazXfCz1NmFF2ITo3GhsjADMuM6MB18H0Ntx8rtLhcwnDvdaLJYCmBzncFSvVJq9v0hb2P511EMgLRF+a4Ehwkh+u3CR3THoKCBENIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQGlgmi1; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQGlgmi1"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f149845d81so57389001fa.0
        for <linux-sparse@vger.kernel.org>; Mon, 12 Aug 2024 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723530837; x=1724135637; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lq9zdQwq9QYoXi3kNAzMmIxc74ryyJ2h1pSyE5ATEtw=;
        b=IQGlgmi1Le54gX+p+W9sMcIIGpaFEq/FIfeTIe7PT0HTTTXLHKK6RDu/vMw+EyhbnP
         0AHuQdczG/sF8LH1dn2hiG50JVJC4nY5KPDxQVkj1ryPWIOouukPWeYkudoe6ajwzk43
         g9amRr0d0SzhYDrEKGb2vLxirHT6uYmuvlYH0zem/bATAbwpl3U9zrSz+nGEXtRA6tKA
         it18hG8jkZ6CwqyyeJLq22kBrqJ2G0I53CMg5worvyyCMRbrFfEnSO2ZLnX5C7gxb03k
         XBfHGcUYWyn3rkQk528xk8Dc4XEa7bJIl8++AE7tHndOGaPXrgVO6NZSZFzfJsC/eFWf
         +whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723530837; x=1724135637;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq9zdQwq9QYoXi3kNAzMmIxc74ryyJ2h1pSyE5ATEtw=;
        b=Ye1LaZzxRnLBuI4EQxeK6ND6gKc+ihL7QF/I5paltgSPKS9qc4kCYeTXFkzfBooao7
         EK5sgToSC4DcC+5X90Uu1DaM4TOggvZxJBfUhF2GW9PXzs3vPt5zdEwBNzmmFysRExRF
         TkWwp7W31CKdQZUjQ+31zslsxNfeKxV132F7a6s9nLixMNJUTXLx3pt0nra/ZTf29EJF
         TtDCPdCz4AQdcvzrd5Nl+wf6lgUNg+A5japP2slY3V1YHGX55WP4Gec52qeheMK41CtS
         TS7Ggtwapk0SQJ5o3HI6us89wIIAhsxDm7Fj6Q/eMVDhaJuVayqI33Zv2ULhJmPEXG2E
         XKMg==
X-Gm-Message-State: AOJu0YzgaSqv5Z9+kCAaVOUYC7BhZtf1LH4sawSuJiSjfC/FMlkQGhlj
	sg97xPzCC82G6qzWMi8SzVTam0ec/LHY7tQF+RTaP9DLGd/wMQKNmoyKw8hFUYJ77GEGEYNlEga
	7WBRJ+9MuK/4NyWbSJ+b7nXHSWt2jwhDsBww=
X-Google-Smtp-Source: AGHT+IERZSoVsLiaXpOjXF8hl7iIAGn/qSEaksIUwSJryklI1EN6d5KeoBVdESigOWdh0OXgo/A+95iTYUq8afUQlmg=
X-Received: by 2002:a2e:be93:0:b0:2ef:2bb4:2ea1 with SMTP id
 38308e7fff4ca-2f2b712cfedmr22440631fa.4.1723530836749; Mon, 12 Aug 2024
 23:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 13 Aug 2024 08:33:45 +0200
Message-ID: <CAFULd4a70uMBT0mby98ocEUy3OiA1U83a9zB+qHmq-eY7AkuTw@mail.gmail.com>
Subject: Feature request: typeof_unqual keyword support
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

C23 introduced a new typeof operator, typeof_unqual [1], same as
typeof, but removes qualifiers. gcc-14 [2] and clang (19?) also
introduced __typeof_unqual__ and __typeof_unqual alternate spelling,
available in all C modes.

A recent kernel patch [3] would like to introduce __typeof_unqual__ to
kernel sources. Since this keyword is not known to the sparse checker,
it breaks C=1 checking.

It would be nice if sparse supports this new keyword and its alternate
spellings.

[1] https://en.cppreference.com/w/c/language/typeof
[2] https://gcc.gnu.org/onlinedocs/gcc/Typeof.html
[3] https://lore.kernel.org/lkml/20240812115945.484051-2-ubizjak@gmail.com/

Thanks,
Uros.
