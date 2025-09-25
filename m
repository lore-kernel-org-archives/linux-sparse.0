Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF320010A
	for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816505; cv=none; b=XyvVqGcgcjkELxwO6uBFw+OseyjyfwVLn/HuDXw+6NU3sfXSNGUI1EBZp2lnXrIxqMioetsCljquyRHBRX/o+W1SUAKrdIywEu8BGa/SC5u4IbU/tkwud5GQoQRRhz+06EhrAeGseZ5ycvMxY9XDKvhJ+p4j4dgD9pNaE4pNFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816505; c=relaxed/simple;
	bh=aZfomSjj8dh0cXUEBE8FFgcoSW2ZLIRjFokhvGeZ4I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apI2VQmJzqplC0cfTNIWmUjv7jIYMXWfzdXDVxyQ0ilyxmD16v7X52vSmjIWnQNXzxT3VFlRr69VAHzq/dTrlo2NzjuaL90F14JXJgiK+a8JsBe1W7T9Ovo0leq9xul81NQbHMY1zNvp9GOyfDpJy4HmL+mYYJjcqNh4jNBnVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63604582e53so921048d50.3
        for <linux-sparse@vger.kernel.org>; Thu, 25 Sep 2025 09:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816502; x=1759421302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZfomSjj8dh0cXUEBE8FFgcoSW2ZLIRjFokhvGeZ4I4=;
        b=tMuV9q6vIyh78HB75Yk744PNDWq8KZ8k3S8yX5fqPMeJ9LwgqMtRmCuCRznf4GbH4o
         ADn6anYFReWTemqhOrCY/Gq7miNnP0C+9gJCEDd6SFYs2vkZhF/FS5pHNRScQXhH9Xju
         gPnCNZu8Tz61cT3tkmWRLbhxnKmcWHXktOpmxhRJmN5sd+m/05YWG8sI9F8AR7frqC5f
         jZ9mU9GTMqO2PRx49AazJ5WvWNB3EM+eMBJIArGDszQuw3F/eAoh7RhMW0KCLEDeMmJw
         7D+ZMqH51gQA4mfjJYrGEYLy5PhZnfl8qGNkpz3FwH4qRL+5sHA0R2Uqlo2OWzrxisw9
         94rg==
X-Gm-Message-State: AOJu0YwHdJOGAwa8w0h6K1oZ6FB+ifz+4yh822SODaWx6OiP3CY2MvkK
	s58x79mTp4iSP3CAZ1Yp+Tyr9ENQer4vsDluZkVPoXIX9RtDOlQUQomRxhtcv5Huf6VCaUBKWbD
	Gz7fSSCDNtq1CmpnM1NLxiWMqMaOCgmU7h/rWe7IkiQ==
X-Gm-Gg: ASbGncuyd6do0hHChvPpggkst86hPb0erfoibRUmTnLZS2cXMZZsm694226juHVJ4E+
	gm15Ql7OESNp0zUoXyyY1J7tJz/BSrWwIgYYFpFTRWrKVe3wfQLUzv6IqzyRgOIefU+JJu10xZv
	pUVxXdPaS/+FodebsIEMlJDS3pXX8xPnYhlJw0mH38bxjdlOvx2xe711eKy188RfFA+uhchbBBn
	aBHqs8ZxMtAmcMN
X-Google-Smtp-Source: AGHT+IG7SEYzsrrThO2exNl0kkYN6/nVHTcjM9zZZoWXpYTUO35vbALVERpNJtT3eH1+uz93ntFbHFb21pvg6haDXrE=
X-Received: by 2002:a05:6902:6b07:b0:ea5:bae2:f329 with SMTP id
 3f1490d57ef6-eb37fc3ef30mr3090243276.19.1758816501993; Thu, 25 Sep 2025
 09:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
In-Reply-To: <09264d38-887f-4a12-961d-82da3b09ad57@gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 25 Sep 2025 09:08:11 -0700
X-Gm-Features: AS18NWB8wdvVUB_KnlQrCMQjMbpIwq1b-tLs_HzEaKv2l3V0_ctiJZxcnBgfv2I
Message-ID: <CACePvbXoyMRLwNJpui9GGf30T8UCzo5JT2jPTBQsSnBtT9kZYQ@mail.gmail.com>
Subject: Re: Project status
To: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>
Cc: linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

I was the sparse maintainer between 2009 to 2018. I am back as the
sparse maintainer since last weekend.

Still catching up with things and finding the missing patch in the
mail list to apply to sparse. Please let me know if you have any wish
list or particular patch you want in the new space release. I can cut
a sparse release after the initial batched catch up.

Chris


On Fri, Sep 12, 2025 at 10:08=E2=80=AFPM Carlos Rodriguez-Fernandez
<carlosrodrifernandez@gmail.com> wrote:
>
> Hi,
>
> I'm currently maintaining this package in Fedora Linux, and I was
> wondering about the status of this project. I see that releases used to
> come a few a year, but no release has been done for about 4 years,
> however the patches are still coming in the mailing list like if it were
> actively being developed still. What is the current status of this
> project? Thank you for any insight.
>
> Regards,
>
> Carlos R.F.
>
