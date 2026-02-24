Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3E372B32;
	Tue, 24 Feb 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928777; cv=none; b=kOFZ5WQAwmygWD4ta/qq+Etem0YHxoR5GNwaZSPlgZKSdZOnfc72tJ5GBwR22Z7tRTzaO4JnqcntsAbF2+QKOVS60LjKjbdEFK9OEGnwnRfvUW+vVUFMVdQ7WSjZDE6opfQtLOt9lrsZoxd68F+l+eJPxygx0XIV+uBnCumw8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928777; c=relaxed/simple;
	bh=T92VV6JKUnoLm55vgNtMzd98POaalEsEjInJfMjJ+XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8CgfzYQl00SOyLvU0OD0GbbRWDqCsyE6BcG/dnDBFPfs/zr9TWZrr9TuZcCCryt7bU1+tvWgRzEEc4VSCW/lFV60eH/VM2vB8o6a4NcyFpLmuqGs55aIkzX01YJ7nvwqMU2IBlf9dIFGtJK0TU429N0gSoTdUVASal4urxGaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdlO/VjY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdlO/VjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771928776; x=1803464776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T92VV6JKUnoLm55vgNtMzd98POaalEsEjInJfMjJ+XA=;
  b=IdlO/VjYeh+Nvwtm2jZ7LEoy6420svLvRSG2I3t75hUs6R4lhg1roT7B
   YUvmMAaXr9jlATlb6l3xyZ0l0NBCSFD5UZ4RkwcaoKtf0Oyo7lTabhLAS
   GiFnr+ZE0Una3KNq/67VTrFWhEAeAV6iRG1eQ+JQ7AzoQwbVM6e1YRNbw
   19BnZsqZk4h+Sx86UBz3B0EVEANBVoivUu8EpG98Tf+8X+nr3NeRJkkpN
   4bdIGXzGQAVAkKvUts3XSfruXHlHP9pX8TIASfHpoiE0tn1xAPrMSN5YA
   vBkgTZVrdIporRUeqsYsaQ155LVJdMheTS2S/poPBj0ypImmcPgOxVtFP
   w==;
X-CSE-ConnectionGUID: uCySn2bFRrSkAqJYQA33Cg==
X-CSE-MsgGUID: aJ+19+xnTtiteCGlWv/g9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72849855"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72849855"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:26:15 -0800
X-CSE-ConnectionGUID: zUfw9g+4RWW0du3ELCnGLg==
X-CSE-MsgGUID: qFpfuHuhRxCGm5V7efXgPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215716696"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:26:11 -0800
Date: Tue, 24 Feb 2026 12:26:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Li <sparse@chrisli.org>
Cc: Daniel Gomez <da.gomez@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-sparse@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant
 expression
Message-ID: <aZ18v6V97ROtJPkq@smile.fi.intel.com>
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
 <aZdAxZR-c8PY_uEL@macos>
 <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
 <aZdighmTJN-JaijL@smile.fi.intel.com>
 <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
 <aZgbw40qk2zIRpbE@smile.fi.intel.com>
 <CACePvbU5ByoP2jZZSHYWCncNNXOQXArvyWpVcinTRag8k3-GiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbU5ByoP2jZZSHYWCncNNXOQXArvyWpVcinTRag8k3-GiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 11:34:29AM -0800, Chris Li wrote:
> On Fri, Feb 20, 2026 at 12:31 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Feb 20, 2026 at 12:06:15AM -0800, Chris Li wrote:
> > > On Thu, Feb 19, 2026 at 11:20 AM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Thu, Feb 19, 2026 at 09:06:23AM -0800, Chris Li wrote:
> > > > > On Thu, Feb 19, 2026 at 9:00 AM Daniel Gomez <da.gomez@kernel.org> wrote:
> > > > > >
> > > > > > Can you please take a look? If Al patch is the correct approach, any
> > > > > > chance you can send it and fix this?
> > > > >
> > > > > I am asking in another thread should I pull Al's git repo instead.
> > > > > There are a few good commits there.
> > > >
> > > > Please, pull Al's work, My colleagues and I use his version of sparse for a few
> > > > weeks without noticing any downsides.
> > >
> > > Thanks for the heads up. I just pulled Al's sparse repo.
> >
> > Can you also issue a new tag (say 0.6.5) so the distros can really be pushed to
> > update the quite outdated sparse in their repos?
> 
> Sure. I can give it a spin this weekend and keep you posted. There is
> one risk on my signing key, it might be expired and I need to sort
> that out.
> 
> Meanwhile, please give the current sparse repo some good tests.

It seems that your tip is the same as Al's, and if it's the case
we are testing (actually using) this for a few weeks without problems.
Thanks!

-- 
With Best Regards,
Andy Shevchenko


