Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97192C08A2
	for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758220142; cv=none; b=unmkMJ152zvG/KOsK0lQ1f+VLDP5mPTQGa5eXfejP+1iWGERvuD3DX/kGM7xbDisHn5EXkTkuSwKMVMPhmBB17hq9ku+/T6duLPciCSj1IThuxqN42/c3me7lom9uDfxj+vO1RduvO+6VfNcWtV9QKJJCYM20k7MBWc7kMkKwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758220142; c=relaxed/simple;
	bh=GIdOGSSbwrFipBobYAUXpMiWLNqu9wX8DyCukfXEwV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad2XcGdwbGG+LEqS4x5MlNJNN1ONm2Tly1HURqn2ix6rQE61LTjPnVSBxj+PR5Up/wiS1ML8zTW6GkcZrKsaGMb3X1T7Z5eg57kdWjE1/vGtRAjF3twMQoglAcBKXfugg3O2N2XN2VaNTGZkwmjHKx3MLoxHklXQZ9431jzl21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IPfM4GRy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IPfM4GRy"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2391596dcfso87456666b.0
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758220138; x=1758824938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQnfssjsrY+9woKgZUZYuw3ll89GvG821dWE8BX4Yz8=;
        b=IPfM4GRygFSRMRZPTjf9R/HNt7L2HwyhpD1oM/pthhF+oUihGfzgM4BzipbHGEOoPB
         ecPuVNAWNQQH6llCAp/o/TEYBagX0yBTXiMMnLac29pxmb94bNNgNi1W4lRfIeLT+HSC
         4gb9XR9dk3Se56mLADMOIQ+7z27fr5bZrgRuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758220138; x=1758824938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQnfssjsrY+9woKgZUZYuw3ll89GvG821dWE8BX4Yz8=;
        b=FV+Tqhkhi6RMWjKiwLpZQzTfZ029oS+UaDbpM1jaa9SJPRZVGPcy0jQxZL34IbMSkM
         R0sbEvYRybEnAwijefHeqqL0D4J3HwHKNvw/cJ+bVrdvU6RYs4Fq+554zbEDBdf47yIU
         0B7LC1saGwjKaTgL4+G47W42+MgXf7ElqTp5/HArjsMX2Tg6fhrrBe/f5sj9AfvjdnwK
         flVjaPRXi3ay8GScKvT9JpRnzjsrAH420PGbnmOhp9IgO2gD5DXDrwv+Sw1rTZ5mPNMl
         z2YxPPbvhyz2ucbGr6dRpj6/Wd+8k5PT9UGbCo846wLWyYhV27lZrhtsOf7v+XgfH0+Z
         EZ6Q==
X-Gm-Message-State: AOJu0Yz3oPbxE6cVEQKiGVmYjvt6EOabVY4D+XkNsWDLz13LwZ/r2YY5
	zCoeeEruxcZQMvlifYPzPFiM2Li0LdAJ0KelkVOMOwS/r5UaV5+I4JaTX2M8QqxT4C2DNchK9mh
	IEASwwVjt5w==
X-Gm-Gg: ASbGncu3a++RsLfKdSnsjUqKOXAc5YgCYAZWDp0/6VAXVg+HQ1bsac6p9gtdoKUfVcG
	ajheMZ3Fb5F5d4bh2XsiRbxr+YCPXp1asg7E7DLgZ9iUYysHqsSzbXhwVNyEoETnnAcPTU3s4pp
	EcA4rdK4eALQtVYkjLBZVr1hAeNzpP7Cr8O6Wl0bk5aswhYCD++G7jpVqfyeCRGpPqJzUAM4otG
	iCkFS/gcAzBnMsIqOMHhYav/4MJs1FeVNsXNkWOcfVmSlX4pBnC62g6LK22PUs7SRx1oU+Ggoyc
	kcTCK/7NOhHUB7hB2VVfHNxK5Bh+7ZldRo1cxWWe89NITdoKU5Ey0Znabaju6Cw8KcgxXaQ9Dc7
	4NzKpolATpC01XP5exDzgDSf0Usldm4+MsYW/SG68JriEoOfVPckiOANd8SZq/E/9PJo1LLbpfX
	DT4GfTn/SYpSXUf0zigRbGf5jUOQ==
X-Google-Smtp-Source: AGHT+IFP/7afEVV9pHIQQUja3qoKNw2YlWUoakrihzqmu3fgEaFHKUsnDcrcReSlN64D7dWk82aeoQ==
X-Received: by 2002:a17:907:c21:b0:b0c:99b8:8aaa with SMTP id a640c23a62f3a-b24ec90a138mr26461566b.9.1758220137831;
        Thu, 18 Sep 2025 11:28:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc890cc88sm245811666b.48.2025.09.18.11.28.56
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:28:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2391596dcfso87453166b.0
        for <linux-sparse@vger.kernel.org>; Thu, 18 Sep 2025 11:28:56 -0700 (PDT)
X-Received: by 2002:a17:907:6ea9:b0:b0c:6cae:51f5 with SMTP id
 a640c23a62f3a-b24f3e5fdb6mr22488566b.43.1758220136507; Thu, 18 Sep 2025
 11:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
In-Reply-To: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 11:28:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCP50Hru1efNTNj23-gMXcbXUEPzt09ivib5JDL5ycVw@mail.gmail.com>
X-Gm-Features: AS18NWAgmvW3zXmVyLDGTSYyzMmAoOB3BrANgEWJwwEOTGza0T-epAsGWWMQrOs
Message-ID: <CAHk-=whCP50Hru1efNTNj23-gMXcbXUEPzt09ivib5JDL5ycVw@mail.gmail.com>
Subject: Re: Sparse maintainership
To: Chris Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 08:46, Chris Li <sparse@chrisli.org> wrote:
>
> I would like to get some clarification on the mailing list:
> Is the sparse project still maintained? I really don't want to step on
> anybody's toe.
>
> If not, does anyone mind if I slowly resume some maintainer duty at a
> very very slow pace?

I'd love to have sparse maintained again, I think it's been
effectively dead for the last two years or so.

I don't think I've seen a commit since February 2024, so I don't think
there are any feet to step on.

           Linus
