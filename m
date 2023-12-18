Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB8129EE3
	for <linux-sparse@vger.kernel.org>; Mon, 18 Dec 2023 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwPweDJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B17C433C7;
	Mon, 18 Dec 2023 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702907769;
	bh=5IdRCz7/D9wGkD7IchHWqXNzEpBmJT5RSbRa9EQ5Uko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwPweDJfI078tF20LBpCTSotM3Ys1xloR0KOceBY7K18ZuhhVbE89dQ+pq+36S8vV
	 ixd4/iWFCv1HC3zoRgkAfc410FTwNNcIfg5sn0hFRTpig1jG+smLPzmG2ofuW53Z/D
	 fjD5HhnfeOcTZzkPLUHF9QFBHTxmOFSe3CSwR/ri1y1zLSe/b14H/nKgtuZtvsfjb+
	 nLvzl3UDeLg+eY0kmgU8bTMHSvMVyQoexgGTIor40ZDAOpcIVkZTMTkzM9GmaFYZXY
	 MOIa0ctyeLVsivz+zdJdwx2YUk/x3BGoJ2HYJn328cAcPMmFLY7THfIZ5PSPA8WvGC
	 Vf2rbhEiC6UDA==
Date: Mon, 18 Dec 2023 14:56:01 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-sparse@vger.kernel.org, luc.vanoostenryck@gmail.com
Subject: Re: [PATCH] linearize.c: fix potential buffer overrun
Message-ID: <q5nxyfe6t4mguhtxtvh7a6wbct4bctj6ynrvd3pftvmiw5rymg@fl4cprexyjhm>
References: <20230222155244.133890-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222155244.133890-1-jlayton@kernel.org>

On Wed, Feb 22, 2023 at 10:52:44AM -0500, Jeff Layton wrote:
> The resulting string won't be nearly 64 bytes, but "buf" is only 16
> bytes long here, and this causes FORTIFY_SOURCE to barf when given the
> right options.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Pushed to mainline now. Sorry for this very long delay.
-- Luc
