Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CF2367CF
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612662; cv=none; b=CduQoE0eHOn70E/AZTIY/Vr0v2yeBmekZH6uBSseajMtyzxLsFLkkgUUF3bBeUbC84tZZ698lp4dE7TJBYOAM1s324dOXf1J3pUdsbfTMqVS786TkkcbBO2c7gJfhEqDglaimmNB2LRC7keC7e/BPdPel6x3+fdL58DB6TEu6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612662; c=relaxed/simple;
	bh=aguL4zGt95/jZP/AC65HJhOCzgUJ8bq7xnkP9VexnPY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=P124xAqQ9gmTh1DBC8pTLtIhxhGpZyeIaidJsx4wkfSDWssrZAI7xtCEA2gBHgYI5APbdGbWF4sWvHsqB+yximzP6pEs3Hf55dPMuDQdWB4zrzdFtFwb8Krcp3UCrkA0rTjV0iZEHXOmQ06+3B7v4ROdHT4bZJohLUFmGvUTiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=x51xpGj+; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="x51xpGj+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aguL4zGt95/jZP/AC65HJhOCzgUJ8bq7xnkP9VexnPY=; b=x51xpGj++T+yVh7uWGme7WVPfS
	UdXTUv1Lgzr/fBSZbhmOKZ+KHqc4BHMU/VUC1hKv1az22gqBpk+/vD2qHS9me1F87KeSnsh76Mt2X
	Augh6QY+CjhCIu8bS0juTcd9GMItF/7S3x8MaYUhRw0SpnMlC4B2dj91oxXFe3Yndk1fsc/Sy69im
	mq1ePPjBvQpUx9kXB3JM+4nPhbnnWOA3mqT7sZPJnPha40nkb6YZwwlhoNk493zqb6sIJh47Piq+5
	zI+eC5KySQAmIQqWGQHfnKPOQR91Ox5sgc8Y8pSLpSuruxTPzexuEB+fI13gBowFoiMLCMpoiTU2J
	QYvXXglg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v9LmK-00Eiaw-SL; Thu, 16 Oct 2025 12:04:16 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1v9LmK-00000002e2W-1yUH;
	Thu, 16 Oct 2025 12:04:16 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>
Subject: Add printf/scanf -Wformat checking
Date: Thu, 16 Oct 2025 12:04:11 +0100
Message-Id: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

[re-send as I can't type sparse and messages didn't get to the list]

This series (which was initially sent back in 2020) adds the
ability to deal with __attribute__((format) and checking the
arguments to formatted variadic functions.

I have been considering adding a -Wformat-linux to this as
the kernel now has a number of extra formatting options and
checking the type of these would be useful. An even nicer
extension would be some way of informing the compiler/sparse
of these at compile time (but would need to get agreement on
how to do this with the compilers too)

Another quesiton is to leave this as 4 patches or merge down?


