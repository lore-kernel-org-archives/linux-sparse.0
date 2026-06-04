Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF72EDD6B
	for <linux-sparse@vger.kernel.org>; Thu,  4 Jun 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580920; cv=none; b=fewkqCOu7ETKFBGurRg+xld1nZ9BbejstevdLCI2QIs7/MTgnyCPFr9pplSpt334RAuxm+X4hiWfttSFs5icv4IGq6um+uFT/A2KcbufM7tEe0jFPKS7AqgK16k5dx+e1flFLYvdDCKld8QNHm/56E62+JJCnzRtqcTdpCXuwBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580920; c=relaxed/simple;
	bh=ZXQ5Ge9LbSRmIFpqQlqxYmZENvpEe1KJTb8FLoNqVMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seyYukGUegBlvln+grdX9OhUnZKiwUuOHXdEuv27pMfPGOqPfE8s/EKg2vHcveqFzNedLOHjg2qNB9iCOhzAJshgALq3xSxHBnZ1tsnPXG1y7UCXVeYe26k0fWQyAs4EfIr/8MgOilqpQi7R3o4Szh+ieZbxDU0FPV5yDkZfkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaieMX+0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaieMX+0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef4223be7so463564f8f.2
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jun 2026 06:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580918; x=1781185718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqfO1FwQR2do80SxAVg2jUVIr5e5+GP9564rj1Xnkcs=;
        b=WaieMX+0EOCDjTFPMXZUAeU40VjCSdvidAVb0GeL/nA5Mk8v8NzKcsIoIXtYQ3gd7Z
         2gqjdrhoqUxKnhFVP8rLThvUz13bMhH6+9rEB+9rvMj0eQxySeO5lN6CI5GWoC859f/N
         SADKki19Ql3NGLOd0jibN8iJtJhiUQi1EbZWL3nMmlNOLMp0H3+Y/Cp/u0OLcUQaQRVY
         dcaMx4zARdyZdl0bVp5iliUuKjJd0L2OSv1VQcJF34Kx93nNrSToG2clDqACyU9dZ9BK
         s+H3mt09CljZOI2wvUeMjCKGYHWBJPMPYrHtfb5iXv8+RdqTBLmiOhqMTrdknZivvHAw
         r+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580918; x=1781185718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mqfO1FwQR2do80SxAVg2jUVIr5e5+GP9564rj1Xnkcs=;
        b=ZosOoqeIy2JIuWARCSFvZf089spGRym2GQyxC85MT4rHAoDM2nUMIoDkSnrgJgpgOM
         +qR3omV97CMUxw7eOTlwfOHCRoQYoTQzKSulMa827zQvxCw4ZDsrOEsL+L5TB8daZlrR
         K8VoZ2Mo1rRpWP2A0n4V9/CnbWt8fIBvq/uKcHv3BQLMpc8Nb4UIaCoiEOLHEVge/Nof
         K/4C8U7DMYCBJWXmGOj1nBpoSH5l2WDcFyiiRFRbuFVfU/xU//RIVGv8CSfKUz04gKtt
         2uX2LQb3spheAUJ4YuOb4ObX8QL6uL8b9SYKeo4HpT7Tzv5MHZeGuYMdb6fggWQVeBYa
         75tw==
X-Gm-Message-State: AOJu0Yy49NzuAhg4Ch2hXqZXjFcF4UZomBugfQwBRvVDkndaMY5P8Eju
	BzWdHMoPKFroe4739+pXnc9TfonrXJLoEbBz7jeptNZbSoucFmMH2B30LyNWzPAP
X-Gm-Gg: Acq92OG8A9KVemz3BleyB8lbABssw3ns/kXSYtS7OczOjW2R4PhSCxB1KUjP7LOFGJF
	4OFi78aPhv39PQNNjRkWCb703zvowAq8pkidxBSyQxqNa5u+wYmPsSnkcGZmbR1NXDRdSIZLolJ
	9EDuHiOj1yQ4e1zEV/JrRDxqAaOB00mye+KpPMN2cJC5i1ISR1NRzUccC+1YZsBFzNLVwiidi9v
	HvzqgIMre0FuFY/5yRatQ5Po9E1i4Be5t6JtNCdXv97NANG+0uuvjmmDSjbZwqfExP7hJ6RxQvG
	7Uh/iJx0+G2Obf3f19DQd5e+/68uV/PaGclxVw9O2+P2BWoWFTe1J36Y9zA3dMqYCaJpkd5abRs
	wzjqe8Hqy1QEquZuENzEFoILq+1EuIOHcNacDSEIYw4qCL1zEYP2scLAtQqlWn3Oxkn1KYpveNG
	oGN6Ox5fKxfaCSNXukU5UJRW30oZ5sOw==
X-Received: by 2002:a5d:5702:0:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-460217a6ff6mr9328674f8f.10.1780580917977;
        Thu, 04 Jun 2026 06:48:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm17090390f8f.13.2026.06.04.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:48:37 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:48:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-sparse@vger.kernel.org
Subject: Re: declarations after a case statement
Message-ID: <aiGCMuw3Lblnc9TA@stanley.mountain>
References: <aiGAXJhYJoUuqB5j@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiGAXJhYJoUuqB5j@stanley.mountain>

Same thing for declaration after after a label.

$ ./smatch test.c
test.c:5:9: error: typename in expression
test.c:5:14: error: Expected ; at end of statement
test.c:5:14: error: got b
test.c:5 func() warn: statement has no effect 'char'

void func(int a)
{
        goto out;
out:
        char b;
        b = 1;
}

regards,
dan carpenter
