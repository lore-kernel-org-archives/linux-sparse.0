Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DE2E628;
	Sat, 31 May 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748672053; cv=none; b=k1ShI9MViGXBGe4BJ//65btguJwbR+28Q9elbcqrWfgF/KfP6epESP2sdycbPHRe+cWL1P87F99nzrYpnRkLYAT6C2Trgvxn7ULKBMRKuH88gOKaSOSH1aaJ5MUHGhQSjZ+hW/cKlfNCG4p2lITR81YUwgJ/DjiiO2D4OrxUvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748672053; c=relaxed/simple;
	bh=bqi6rJ0hiVr8slNOa6h3sST0DYxL7m3H/YQ3HcJjmhU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X4blWRPMl8InCGvqO31UfsTw+JLUqZJd9VYzlIzHZ45iC8FG3Cb2hK1BFaZYRW5Xy9VvVbxhi20wWNqcwaYPcl1n7iqjT5yJp140ocDHB1/AD777xMxtg0kKdHIMqLlLCGzTi57kAg7m1Jo7JAa40ZUG5q0eKurE9nZ3BNKw7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Szt+Gcdq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Szt+Gcdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748672051; x=1780208051;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bqi6rJ0hiVr8slNOa6h3sST0DYxL7m3H/YQ3HcJjmhU=;
  b=Szt+GcdqjnF/v8/IqrJT10YH79e8Xfvvm/qcf6QQ8HMfHVWk3eGHgIsK
   cuk2wTgweD8nXsL3HUOYPWgS56DvOxxpp/5GAdueOqVPkYprz5hEbdM9X
   6Mzs1XZrhht1CIu7qFk3oysh70knsdYTRBNJhvWrYJxNFAHFH/QxscubE
   X5JrgwIybzVMflDhWsvZKJviZla9RY5Cd3XAczvJqb1HAmhtMlsWOBQpE
   tpdSxeQRsmZ4dwfMiy92Ug9d6Xg+Ne+91bx+Ke9ZVVxB5dym8s9I2LmfT
   KMObahQD6glgIQMTpfNk52kURMDp0cJ77ttU36z1HR6MnsuaOnCynHln7
   Q==;
X-CSE-ConnectionGUID: g3AVgr+tQrSNQrz/s1Kdsg==
X-CSE-MsgGUID: HJlWUEPJSSiSXgO55qFOAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="54429665"
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="54429665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 23:14:10 -0700
X-CSE-ConnectionGUID: zk+4zkahSJioxj5UcKUAKg==
X-CSE-MsgGUID: vHJUI23TQWCCrPFGUJPBIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,197,1744095600"; 
   d="scan'208";a="144038811"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 23:14:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 31 May 2025 09:14:00 +0300 (EEST)
To: Derek John Clark <derekjohn.clark@gmail.com>, 
    Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
    linux-sparse@vger.kernel.org
cc: Hans de Goede <hdegoede@redhat.com>, Armin Wolf <W_Armin@gmx.de>, 
    Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>, 
    Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>, 
    Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    "Cody T . -H . Chiu" <codyit@gmail.com>, 
    John Martens <johnfanv2@gmail.com>, Kurt Borja <kuurtb@gmail.com>, 
    platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/6] platform/x86: Add Lenovo WMI Gaming Series
 Drivers
In-Reply-To: <CAFqHKTnp2zMTAfdYBpxestSErpsgwSf_TmkLjjU0W5HOFiC9bA@mail.gmail.com>
Message-ID: <e98eccf5-1006-3d1b-d2fb-783637807ac7@linux.intel.com>
References: <20250522015350.471070-1-derekjohn.clark@gmail.com> <2972c4c6-7080-e058-ec39-b8c1dc603f7a@linux.intel.com> <2c7ffaa6-e639-e215-42d0-78a2b185ad45@linux.intel.com> <CAFqHKTnp2zMTAfdYBpxestSErpsgwSf_TmkLjjU0W5HOFiC9bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-43950218-1748671245=:937"
Content-ID: <8ecdec3f-fb03-044b-ec92-17e1a21e1ebd@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-43950218-1748671245=:937
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <f0193626-50b6-a117-7794-a28eb0b5443e@linux.intel.com>

+ Cc sparse people.

On Fri, 30 May 2025, Derek John Clark wrote:

> On Sun, May 25, 2025 at 2:42=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 26 May 2025, Ilpo J=C3=A4rvinen wrote:
> >
> > > On Wed, 21 May 2025, Derek J. Clark wrote:
> > >
> > > > Adds support for the Lenovo "Gaming Series" of laptop hardware that=
 use
> > > > WMI interfaces that control various power settings. There are multi=
ple WMI
> > > > interfaces that work in concert to provide getting and setting valu=
es as
> > > > well as validation of input. Currently only the "Gamezone", "Other
> > > > Mode", and "LENOVO_CAPABILITY_DATA_01" interfaces are implemented, =
but
> > > > I attempted to structure the driver so that adding the "Custom Mode=
",
> > > > "Lighting", and other data block interfaces would be trivial in lat=
er
> > > > patches.
> > > >
> > > > This driver attempts to standardize the exposed sysfs by mirroring =
the
> > > > asus-armoury driver currently under review. As such, a lot of
> > > > inspiration has been drawn from that driver.
> > > > https://lore.kernel.org/platform-driver-x86/20250319065827.53478-1-=
luke@ljones.dev/#t
> > > >
> > > > The drivers have been tested by me on the Lenovo Legion Go and Legi=
on Go
> > > > S.
> > > >
> > > > Suggested-by: Mario Limonciello <superm1@kernel.org>
> > > > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > > ---
> > > > v11:
> > > >   - Fix formmating issues.
> > >
> > > Thanks for the update, I've applied this now into the review-ilpo-nex=
t
> > > branch. BUT, this is very late in the cycle now and if there's a buil=
d
> > > issue (or LKP doesn't build test it in reasonable time), I'll have to=
 drop
> > > this series and postpone it into the next cycle as I don't want to de=
lay
> > > the main PR to Linus too long.
> > >
> > > But lets hope for the best, I think some depends on issues were fixed
> > > earlier (IIRC), so hopefully it works good enough now. :-)
> >
> > Hmpf, these give me a few new warnings related to this series:
> >
> > make W=3D1 drivers/platform/x86/
> > make C=3D2 drivers/platform/x86/
>=20
> When I use scoped_guard the warnings go away.

Okay, not that it helps much because the implementation of guard() and=20
scoped_guard() is dramatically different.

> It seems to be a
> limitation of sparse in that its not correctly identifying the guard
> will be unlocked on the return perhaps?

It's odd because we'd have those warnings all over the place if it would=20
be general thing for sparse to not understand how guard() works. Maybe=20
sparse people have some idea what's so special here?

To give context to sparse people, this patch triggers two false=20
positives in sparse:

https://lore.kernel.org/platform-driver-x86/20250522015350.471070-6-derekjo=
hn.clark@gmail.com/

$ make C=3D2 drivers/platform/x86/lenovo-wmi-gamezone.o
  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CHECK   drivers/platform/x86/lenovo-wmi-gamezone.c
drivers/platform/x86/lenovo-wmi-gamezone.c:155:12: warning: context=20
imbalance in 'lwmi_gz_profile_get' - different lock contexts for basic=20
block
drivers/platform/x86/lenovo-wmi-gamezone.c:206:12: warning: context=20
imbalance in 'lwmi_gz_profile_set' - different lock contexts for basic=20
block

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.=
git/tree/drivers/platform/x86/lenovo-wmi-gamezone.c?h=3Dreview-ilpo-next#n1=
90

(That code link is just for convinience, it's not a perma one, I'll be=20
overwriting that branch eventually once the merge window is over, if not=20
sooner.)

> In any case, if you're okay
> with a scoped guard here (matches both other invocations) I'll send it
> up.

I'd prefer to keep using guard() for now as this looks clearly a false=20
positive from sparse, not a problem in your code.

> I also took care of the warnings for W=3D1.

Thanks.

> > ...I really don't know why sparse complains about the lock context
> > imbalance though, those functions use guard().

--=20
 i.
--8323328-43950218-1748671245=:937--
