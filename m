Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7330DEB8;
	Fri, 20 Feb 2026 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576268; cv=none; b=mftRUYtiWdr9JsDvDf6XQhb/jiilM53PAMZQrMznLiuC7aBMQUhf9iN+oX23jPEulkP3AnJgAm3NIyQ6LVit4WYgMUotWuuNQ2Buq7rXZsYczucFcrcqzwij7iZ/XSO0nj8bRwhZZw4pwrrYNCeiXZMzODSnU5+OWefBQPJIwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576268; c=relaxed/simple;
	bh=5OxdbjN6P6byrb9BD3oHX2fy3Q6b9HNNwDCo773CwxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzuA4sTVQSw7qPtki/4e2zZG6MFNmr5HpurQ5FrMUdmZHTuZSeQfeAIG8vic2GVV1RdZRMMzT8SXX3AsCIrtnL511VVovDrNDu4pYKF4CMTqu56dooqrgFO3hYr6rz6rRcdbGa9EURb17IbIygVGjbbH5xoF/LujtOStWkAj0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7t9Efk+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7t9Efk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771576266; x=1803112266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5OxdbjN6P6byrb9BD3oHX2fy3Q6b9HNNwDCo773CwxI=;
  b=J7t9Efk+dzKYDiyJL4Z464pXl42pT1hPyqt1IMzMgHb+YPkao8KKilsr
   zENpxfppiHpSThHVPeHFKbikD2kPWPWR5SZFTa1ty/2sJCfAJD43DtAOq
   dw51EJlazsr9ziH+RtQwseYQYbnnwa0sKl7xn5IOZEmGsHPn8fYiA8kJq
   4OPiri+OD6vHajhWpYeU9RcUbKMflXX2tlZmDvjB54OYH0957jnIYl9Rc
   CUl10OOgUZ7pKy6TB3U9haXbp7eP4an8P9H/J8/tGzXBd/UCd4GZ+MpNd
   vxZUU+k4klquhN21Ho82cmAUhR27gxf92xPqAmwMu31CTgw1lEJ1HVrnn
   w==;
X-CSE-ConnectionGUID: P+IlD2sBQziAKYfH/ukA1g==
X-CSE-MsgGUID: cz+VbwMwTQKIdHJWqXmIkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72730607"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72730607"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:31:05 -0800
X-CSE-ConnectionGUID: iquXS/LDQAO7lebzXsRNoQ==
X-CSE-MsgGUID: 03rqr4P4QH2dWRLdFNEYdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219300287"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:31:01 -0800
Date: Fri, 20 Feb 2026 10:30:59 +0200
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
Message-ID: <aZgbw40qk2zIRpbE@smile.fi.intel.com>
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
 <aZdAxZR-c8PY_uEL@macos>
 <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
 <aZdighmTJN-JaijL@smile.fi.intel.com>
 <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 12:06:15AM -0800, Chris Li wrote:
> On Thu, Feb 19, 2026 at 11:20 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 09:06:23AM -0800, Chris Li wrote:
> > > On Thu, Feb 19, 2026 at 9:00 AM Daniel Gomez <da.gomez@kernel.org> wrote:
> > > >
> > > > Can you please take a look? If Al patch is the correct approach, any
> > > > chance you can send it and fix this?
> > >
> > > I am asking in another thread should I pull Al's git repo instead.
> > > There are a few good commits there.
> >
> > Please, pull Al's work, My colleagues and I use his version of sparse for a few
> > weeks without noticing any downsides.
> 
> Thanks for the heads up. I just pulled Al's sparse repo.

Can you also issue a new tag (say 0.6.5) so the distros can really be pushed to
update the quite outdated sparse in their repos?

> Sorry for the delay.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


