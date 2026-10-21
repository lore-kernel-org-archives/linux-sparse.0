Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.62.254.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587750;
	b=w5j7qrIDLiZzjpNPyFYjhG17gi/0obDu5Xhg4gfBmhNUaH/IUmlAl47DHzhCtiy8OtzI
	 5qNU02v2SfcdH2QdrLfSXl9H0nrtCA12S/TTM/uFCwvZpRfsrPcQahp9HhcbEfC6oyird
	 i+hHFH9kJg8UABaFVfmMLnT8TYRYx1186wQQnS+ZB2poD5eYOZTwHsL+GnmI0f1Yi2LGv
	 yIBnDqcw2fNaTeq8rIyHKWeqgOr+gzcnionDwZdTYzDFE38cXb6Xh44bN9JASvLmHr4Cz
	 MrBIQt29BL/qxeGBar0XVetZg8gDDFyvRc56x6NPO9tkVrckekyPrmmhXyyEAd+JK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587750;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=R48OF87czPw0TpGGjpU0V3r7D5EariSaDx8Cyx/9Vio=;
	b=wVGmwBuqCUcVJvaBTKy3GFaan8v+VafC3pkk7vrByXYTNK1vukryBKMuHnsXgDP8g5ln
	 iMwwZk+EakKVqxabBdQAaRL29rOUkCWP/JfLTe0OW/RqO8KHl1IALEiYib4I7YVK8vxdb
	 BfnV+Mz+NK9TvgONLJbhTT5DjbAYV5ZifQpYrRGDhQJMDBZ/vwMK8Aymjr+zhH+5blVEB
	 /POzhurEc9rTl3lA7cMg6qVy4bAnvNEUE2sSmyfZ/akXxzxjW2niXqsai4corlmUiVEIR
	 QBP2h3qushjSCkUjtvQeg2KvBUtJqpe4IxGHhxPkYbIeCltwsBAcGCkkfMG/ZGeOV5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ilvokhin.com;
	spf=pass smtp.mailfrom=ilvokhin.com;
	dkim=pass header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=tOXjYJ8J;
	arc=none smtp.remote-ip=178.62.254.231
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A15606A319
	for <linux-sparse@vger.kernel.org>; Wed, 21 Oct 2026 13:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A15606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ilvokhin.com header.i=@ilvokhin.com header.a=rsa-sha256 header.s=mail header.b=tOXjYJ8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792587742;
	bh=R48OF87czPw0TpGGjpU0V3r7D5EariSaDx8Cyx/9Vio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tOXjYJ8JY2P9XMGCzrJpYR52saFWfKXmioqyeU7N90wkTZfPJALrDZa/Q5EJ6AizU
	 h5+PeII4FNATy7bsT7fVygC2i0xeFXdHF0ZtFUOlBqBIogfEaWDRdnt4o0RCXJ0IUO
	 k1CBaJVHzqBVsgFoMUjRIK6S5UOG7B7Nhol3LaFs=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 5F5F2FB941;
	Wed, 21 Oct 2026 13:02:22 +0000 (UTC)
Date: Wed, 21 Oct 2026 13:02:18 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org
Subject: Re: [PATCH 02/20] ptrlist: Guard against null list in ptrlist
 operations
Message-ID: <ati32i58qty0xXQn@shell.ilvokhin.com>
References: <20261019175633.415493-1-bvanassche@acm.org>
 <20261019175633.415493-3-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019175633.415493-3-bvanassche@acm.org>

On Mon, Oct 19, 2026 at 10:56:15AM -0700, Bart Van Assche wrote:
> Guard against null list pointers before accessing list->rm in ptrlist.h
> and ptrlist.c to eliminate undefined behavior and UBSan null member
> access traps.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
