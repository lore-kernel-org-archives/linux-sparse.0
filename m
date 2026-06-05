Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C33B5835
	for <linux-sparse@vger.kernel.org>; Fri,  5 Jun 2026 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638644; cv=none; b=BKGLDb/vfN/RVxVfewfa4kXgm/unwWFr8mhkZyloGIP8D+mb4Bi+zwxpsbFuAxxy0FZIqW38UUsQurnWhjprRFbB58GLcbLiHe8Z/+2+EDzKolKJ3jrOvNCmLLZqPcYTTZwr8EYi4yMba52SrftokQmhRLNwdYzsGOghcTPYvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638644; c=relaxed/simple;
	bh=whd+Q/rmxZ1ttAUXJ9IZJ4Zk+PRCwZ7eH5WcbDUi7uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkfOCEQU6JyN38rUf/LUJvIuWU7goX8NGVdcpHBCKcS3T86wfEYz+rzHxCEGRrODJu7qwSGnVhAcHJPa+Nxk2i4UIl9MS/tpg4K2nFU7rVJCHivBkNXufwoX+d9OA95qes/ZoLdL8dpbdoQIr3nffHtRnL0P72PJZeMjpmX9Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGnyETw3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGnyETw3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so12324125e9.0
        for <linux-sparse@vger.kernel.org>; Thu, 04 Jun 2026 22:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780638642; x=1781243442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npDYus1R9u0tnf7xCAu85ZbVdQYU0qHdsX4m7p/Q6lY=;
        b=NGnyETw3zOCmotvrG54YCKnY0lk3gAlLriEUf20jDM7F0Fl6q3P6MZZPHDMItYSmIl
         Pe+wkAZq//iSGfYLD6XZpSMSrxxwNmOK5IcBGxw0ObTi3JpLyMY7jxPsknujPl/SDcI0
         ZW7mg9qJfKYXpZnjdQ2ep38msugV/L06z8eLSnjbqjsDAD+pDADHvYiWRhlm0tUKkk8a
         Tr1nKeHrfq8FGfcFmDdU4XkoaEUsfju301kwJcHaFyIOJzRf/mVhxdOkmQrKeQThCvos
         2hACXMTOmOyUiuz0YKBIrO5C9Mg9LHlVHdWZPg2goF1zuX+Q9ccQ7/EK9S0bdylBFoRa
         qXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780638642; x=1781243442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npDYus1R9u0tnf7xCAu85ZbVdQYU0qHdsX4m7p/Q6lY=;
        b=ZYZ/E3BA6NV/BvCB8NV5e3/+iQL9wKlYx7oikDebcBSoxLq8Ti54efdppuwaj9A5Mn
         6Cjh1DoKHRK1W0t5hXPJ9kudK+j2VfUyur+KmDznUIApt4Q2TUXtQ1nwbmgxPCVhysXe
         9JxFqqO6mU8GBP0LkBJVz+n7gqac++On8IJ7dGNDC4gZz2fAOuQHlzSh2C/i4uzrd+n0
         XA0ZXiAkiao4HTWr2wGwMTis8/K6K9qayVvklw8dn9bCiGModQA57sVEl6DCd6xEMJ89
         3322DrHVDxBYP8jzDbaUwuJncjruCa2+iY6WVsA7iuhjwWJzbI/ES2Cav3t0pV+fWiUX
         LiJA==
X-Gm-Message-State: AOJu0Yzx0ttKqmJS7MBA+8txqKV84f+S7cvtd0ub+5cVlfKPSLi7HYn7
	PjQPKUsm7RoveMJwAz1DeOWTrTm4qResYrkXntjvsPgABmpkjlERaXjDrhm71tov
X-Gm-Gg: Acq92OHHIJII0EH5/Ws4jCfP72AXH3orWV4cUqsL64Q/UIJNisRoHo4+Sf0R0BU/8PW
	ACVIcRj1MpYA2jB77WwKVDhT1pGIJCgapKUx3ncyg2+sS6YUY2UTDxeT0tWb9dZQMlyq591ei4w
	jEi8naOyG/6hzHN8NeFnN544mQolEpFLCddHJse7aOFCH8Bm5Y3+b9UP/eCiIPkL0PxYSYkGdZT
	jPdKGvu5/hlLXKYHbMAEcEwQRRNHNWcbiZ5yU/V8CqXG/5P9safDl0GSHoTFpvy6WzdYQMSUreq
	dUdhe+FdhY1y4t4ikir3ZYpPPUmsxidzFfMLJqOyyO+NMwqQbvgoeBl9SBLRIrZJNs9gHx9O0Um
	I5vVQ+bhbEfYgqeFHRtvDHjnMS2PkZuRb9g1yxqRNiz84aCHGCP57RukuvJRvb/buXGhSX7XOXe
	jX0XDh8S5LpaL0pmvesM9I990jpSLQlg==
X-Received: by 2002:a05:600c:8a1b:10b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490c265c075mr16750535e9.9.1780638641780;
        Thu, 04 Jun 2026 22:50:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d52e5esm14278145e9.2.2026.06.04.22.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 22:50:41 -0700 (PDT)
Date: Fri, 5 Jun 2026 08:50:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Derek M Jones <derek@knosof.co.uk>
Cc: linux-sparse@vger.kernel.org
Subject: Re: declarations after a case statement
Message-ID: <aiJjrf-X8zB7fLWI@stanley.mountain>
References: <aiGAXJhYJoUuqB5j@stanley.mountain>
 <aiGCMuw3Lblnc9TA@stanley.mountain>
 <fe4a18e2-c398-4a3a-b8ca-be9e7ed33ba7@knosof.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4a18e2-c398-4a3a-b8ca-be9e7ed33ba7@knosof.co.uk>

On Thu, Jun 04, 2026 at 03:21:00PM +0100, Derek M Jones wrote:
> Dan
> 
> > Same thing for declaration after after a label.
> 
> Sparse is correct.  The usage you describe is a syntax error.
> 
> A label may only appear on a statement, not a
> declaration
> https://c0x.shape-of-code.com/6.8.1.html
> 

That's an awkward thing because GCC allows it and the kernel is
doing it.

net/mac80211/mesh_hwmp.c +373
        switch (action) {
        case MPATH_PREQ:
                struct ieee80211_mesh_hwmp_preq_top *preq_elem_top =
                        (void *)hwmp_ie;
                struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
                        ieee80211_mesh_hwmp_preq_get_bottom(hwmp_ie);

                orig_addr = preq_elem_top->orig_addr;

regards,
dan carpenter

