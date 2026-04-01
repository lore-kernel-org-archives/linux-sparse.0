Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBF3644D4
	for <linux-sparse@vger.kernel.org>; Wed,  1 Apr 2026 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074741; cv=none; b=QJDc0TsrNYs/typyp7mu3st/+LCUeJg8ECHFU2F4kjEmuVs49nOZ7+cAgnRn1vVeOUjUIE2y1zAWiPJgSoYdpR1ar8BD/oHHpKJksO5MTjWwpUhtNL/wUx541hkvWyJwGlV1OhfEZ+GT/3fzARAXFdOuE5sXR+jNzDkl3rJaYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074741; c=relaxed/simple;
	bh=DkAYw1BnFcD2ITxaumO5aBZYwdf6TQqhJ98CcXPuRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDiWY+NRA4gsAeEsCbNgc+8+XAbaDb+KvCRkHkI2Wr6RFFLCOVXTqm1pLnp+fxNX6dQrG/b/qKL4KthXqXP2xZk8jMzjKFiOGfU1sHVrk7Pq9ZdvR7H9l37TT39mYPMynL1LMlI2Q5ZfKTgYgr+ev0ueVnwuYH9Ba7oYpo4jFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KDV1W1Ta; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KDV1W1Ta"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pz0ya+G/p0QBVKY781XLh44QurEE8Wumz+EZjItEL4Y=; b=KDV1W1TaC9UekGwMSUxeJDbXm0
	Vdv0EPc1HVaxjtyO1aufH+DX8kPbVzvPuCsCEVEmJ5xgt42RE5sL7+qe0uiKdiTVhd86uqSco1IAi
	q3PYLR5j0W8aQ9ooRWB4L51UxtCKtgW8dVZLH2bfh2n+1+Z/PN3QBsUo1ws0V9lRMU93ntEyPSP/L
	Q0BdMDXzt0ez/Qsp/HVBBdDhHvS4mNYWHfuAhr2AEvosaytddygq5zsNB1aq7nMkU/JehuXevRJ9N
	Tcjoc4t09eJ2p8n48QDkUrs5Nz7SJpExOrbs329D5EjGEP6FLZEZmDZa7PMyTg2IuRzD7zAYI4H+j
	VFFcpMMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8258-00000004GU3-1MLk;
	Wed, 01 Apr 2026 20:22:31 +0000
Date: Wed, 1 Apr 2026 21:22:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: chriscli@google.com, linux-sparse@vger.kernel.org,
	dan.carpenter@linaro.org, ben.dooks@codethink.co.uk,
	rf@opensource.cirrus.com, Eric Zhang <zxh@xh-zhang.com>
Subject: Re: [RFC PATCH] pre-process: add __VA_OPT__ support
Message-ID: <20260401202230.GB2063236@ZenIV>
References: <20260225072731.GA3093958@ZenIV>
 <20260225081413.2480484-1-zxh@xh-zhang.com>
 <20260225221851.GE1762976@ZenIV>
 <20260226072945.GA4104757@ZenIV>
 <20260316065622.GA607739@ZenIV>
 <20260331080631.GA1328137@ZenIV>
 <20260401103919.GA2063236@ZenIV>
 <CAHk-=whC+8jX=t9NsF3uG_=BoLDNG7q0+FCm4ZrQDFdirWaasA@mail.gmail.com>
 <20260401195251.GA974193@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401195251.GA974193@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 01, 2026 at 08:52:52PM +0100, Al Viro wrote:

> Something like delta below ought to take care of __builtin_strcmp(); figuring
> out the things like "ab"[1] being equal to 'b' is something I'd rather
> leave for later - at the very least after I resurrect and repost the
> busy-wait in shrink_dcache_parent() patchset.  I've really spent way
> too much of the last couple of months on digging in sparse ;-/

BTW, gcc doesn't accept a trick allowed by clang (as well as by sparse with
this patch):

#define splat() ({	\
	_Static_assert(__builtin_strcmp(__func__, "foo") == 0, \
		       "use only in foo()");	\
	something();	\
})

gcc does not realize that __func__ is a constant array with known contents.
Oh, well...
