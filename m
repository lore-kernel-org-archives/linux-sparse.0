Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CF4657E5
	for <linux-sparse@vger.kernel.org>; Wed,  3 Jun 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476099; cv=none; b=CPCV0fasp4btYZrTnnczbKJlKBV4jf1LSrc5Mf7rsFi3EBeqA4v8asB4CB0imnzhfoJJVPKPuy4R0F1vXimR0FdVg9TLV7DzumvxjbkpYDbX10dB+y9C/6SjJD6znqkM5XU0y5eQ7Wy3/Cl85BSietN2bawSBX2EPO91TZ1QYws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476099; c=relaxed/simple;
	bh=WaTjUjzc7nLlbEtzsjBSQFMhfPL6ITkZ3xKF5wzbD5s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TAOThOQqrUXCvSaRJOnMzmTqDYTJyPybfbLr5YZGHLsD3rwYsz4DTN5dHgnlajZ9LqcxtEG9UsB5vQqLED/mqXQMObmMHB+m49fxufdGDqE1JKmiqHi4001fbdvuQMDDd+Eq/5Q5uaQBOwXThUOr3KmH7PLMWWu7EuqzW34Q3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIv1cg7G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIv1cg7G"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4905529b933so98569465e9.0
        for <linux-sparse@vger.kernel.org>; Wed, 03 Jun 2026 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780476097; x=1781080897; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJgXWCTxYli6+n0zYOU10br7T2rBzgeJVoJ7VY9FI48=;
        b=cIv1cg7GsFlTqhnozuCaHYSHeaJRwams8xczh55jhW6WqsjF0ojK0XF+8w/UhPvrQI
         VPJTUedd9Lp5KRwcp8UYYuNR1fgNOMpTlckumbAzlqVkjVErfg2HF7Mx6zxgTcGXTR5q
         S4oLkBq5tjcBIxFa/XS1sOvqA9csOYUz5vgPKBmH1hTFnoUwHn1VY5pt/oF6ENuFfyJJ
         8X2zvO1+VIskV0rLzyQ/2bK0Lnuxn0EGCiCdgdFLTgWdY2Z5WLyRLsD8sTmCwecjbcpY
         lvYoegtjXklRJ0MTl8/qt/wv647yVx8X2sEyp1BBSJc7d3tplXwH8QUxGymQpBk0GWmL
         gj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780476097; x=1781080897;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJgXWCTxYli6+n0zYOU10br7T2rBzgeJVoJ7VY9FI48=;
        b=amLtvttxVX+5u0zQ6adv7W1Ku/XF//w4ku8IA9fbAYLjq5A6QCP+aD5K/ttq1/ff17
         +u1KZ7q9017Ij45HiqQOPTlus1OpWSK/5I1etpcvJrOX1NpMwhMskIcDxJgfBE1pFs0d
         jg1W1HfQ+nfEhCetW4n3BlAhu6baeP26qRKDDghkNKJnvYpeB889ijHKDlYVgtqj632V
         I9wA+ALV3gOY2JZ2/y88SxeCf+SdiFjS4j32clk1fXADxGhs3j38WgOkoTMdC8mwYPTe
         4oN2OzeUJRjLDazeDlv41UDE8KABaPg/79N94yPa1MocpzilgUMpZQ6lTnZByp8smJ5x
         Z7Yw==
X-Gm-Message-State: AOJu0YzlbpYuj5OFg4H4/Q1S1B7ejZ0HB2y7muDhVyNkVSlB7YkjaUEu
	tH2LpRQ+Mf9iexEmEQW/LCX5KhGSQ27fD3gt3RaQYUchB8cbTFNTJenJ2o0+/Q==
X-Gm-Gg: Acq92OF0pF+kjcPHQdLpjVi9BgCCHOfnJ9GV1SOwjhtDA1ZTkwtmOPMruUCMbGL4Szc
	of2y+rA2Y4v38AL+/2SzDvtw6Lp6j4FRO5Tx2vN0DKCw1cGxckyxZ3qGZgp/cafNbx2eCbTXp3p
	SBKsYJ/+u4jJAU2bxZhS5f71XCFrJ2iHGmVvm7UhLxq7NkEQsGMQ6sPcJqQyMx4iJnSJ65/ki7o
	rb6q5ejSWctjdSMXRSDdQh6CQqayf9q8OIRC/7HsVQyn02cdJRz00liaIucSPj04G0TrL0rcuTv
	S1t4MQgvOCq8RBgd9kB6PKkDeAf0f3btptZ8X7CIM0TXk73pKbXnn8M7+jSrgZ1GAuS+Pscp+i6
	vJ2TBWDwBUsrr0OaZJEHP6iIZBkrx19wJc9EjPioxqApaOb8TIg7q6ZSu5eROPBwoDvBw1n02Yr
	Tdh+iL4tB5GyHXiUqPMQ1l/Y4JNFy87Q==
X-Received: by 2002:a05:600c:4fcc:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490b5ebfc5amr40951975e9.24.1780476096779;
        Wed, 03 Jun 2026 01:41:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b725fb1bsm35517955e9.8.2026.06.03.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 01:41:36 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:41:33 +0300
From: Dan Carpenter <error27@gmail.com>
To: linux-sparse@vger.kernel.org
Subject: handling cleanup attributes with a goto
Message-ID: <ah_ovV_KtDXan8L-@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If you have code like:

	for (i = 0; i < 10; i++) {
		struct foo *buf __free(kfree) = NULL;

		if (frob())
			goto one;

one:
		blah(); blah(); blah();

		if (frob())
			goto two;
	}

two:
	blah(); blah(); blah();

The goto one won't free the buf because the label is inside the block
but the goto two will because it's outside.

At first I thought I could get the scope that the label is in from
the stmt->goto_label->label_scope but that's scope where the goto
can be and not where the label is.  Is there a way to get the
information about the scope where the label is?

regards,
dan carpenter

