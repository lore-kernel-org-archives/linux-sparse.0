Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ACF1EB36
	for <linux-sparse@vger.kernel.org>; Sun, 17 Mar 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709425; cv=none; b=biEcTqKO+ED440KLGtOc8wl28h07QwMSbmP8IyApUcegsau1m1aDpvInAyoe3antotsJl+W23uGK6Hm6sDfluOrgN7dMUhtsjCzRsuhUoFYZKVDqHZo9pCcTy5j3p5DhLI9OBUO32GymtvdgN4T5NdCPMkQIQy5dfz29RfWV8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709425; c=relaxed/simple;
	bh=gzAePpCELiWiEVfOVWT+m6Mi8Uw5yBEyROgjtW+MVi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Bf6JRkxgcFiLDFbzh7e46OGI9HHfrLUSavc3EiFEmAFv8aysacUssx9IKEvzOn2wU3x4tblxXnaHpAFB5LlgTtmaOp9XyyH/B6G9CACjmbrPgTaHPoeOKTH07m34fjq5Z2QKWWeouWvYU2wUuQVw59K3zHhRZf4SK1zPiJ/OMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-WNWPfMjyMNWwIlf9U6Qn3A-1; Sun, 17 Mar 2024 21:03:34 +0000
X-MC-Unique: WNWPfMjyMNWwIlf9U6Qn3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Mar
 2024 21:03:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Mar 2024 21:03:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>, Linus Torvalds
	<torvalds@linuxfoundation.org>
CC: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
	"lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, Arnd Bergmann <arnd@kernel.org>
Subject: RE: [patch 5/9] x86: Cure per CPU madness on UP
Thread-Topic: [patch 5/9] x86: Cure per CPU madness on UP
Thread-Index: AQHadz7YjtRKJ7LFXkWK5JDSHprIDbE8T4UQ
Date: Sun, 17 Mar 2024 21:03:16 +0000
Message-ID: <285eeccc46bb4d5bb471071964ddce48@AcuMS.aculab.com>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx>
In-Reply-To: <877ci3j80k.ffs@tglx>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner
> Sent: 16 March 2024 01:11
...
> We want SMP as a general concept and overhaul the whole kernel to get
> rid of this ever increasing non-sensical UP burden. The real world UP
> small system use cases have moved over to other OSes like Zephyr & Co
> long ago.
>=20
> Just because some esoteric architectures (m68k comes to my mind) will
> have serious issues with that for the very wrong reasons does not mean
> that we should not go there.
>=20
> It's going to be quite some effort, but the overall benefit is worth it.
>=20
> OTOH, it's absolutely not rocket science to pretend to be SMP capable
> and if some architectures fail to accomodate on the way then we just
> should remove them as that's a clear sign of being unmaintained and
> irrelevant.

There are fpga soft-cpu (eg Nios & Risc-V) that can run linux.
They are definitely memory constrained and really wouldn't want
most of the SMP overhead.

I'm not what it involves apart from simplified startup, compiling
out IPI and spinlocks and optimising per-cpu data.
But you wouldn't want to be running an SMP capable kernel on such systems.
x86 is a different beast - except perhaps 486.

It has to be said that I've never understood why anyone would run
Linux on a Nios-II cpu. Far too slow for anything useful (you might
get 100MHz if you are lucky), caches will be small and external memory
accesses slow.
I doubt soft RISC-V are any better (and I suspect they are worse).
We do have 4 Nios-II in the fpga image for a PCIe card.
They run very small programs (one has 2kB of code memory) to do things
that would be impossible to write (sensibly) in VHDL.
There are fpga with embedded ARM (and probably RISC-V) cores for
running real OS.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

