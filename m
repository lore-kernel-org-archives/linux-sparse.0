Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FC76C6E
	for <linux-sparse@vger.kernel.org>; Mon, 29 Jan 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549948; cv=none; b=hws/yjDOaAjDNSWui4imeERgBmKxrAQpL8R9SxjDVAJTvcLSeTjgukwyPWdR8qBhLuxxzPIXKk2jFjZJxMkYNP4aTGAphG7DK+zn8rZTPUrV42oMVtCwLoV5oZ6T8A1B/k45WuhUoj/Wd/JrRTkiIi92AV/NEFntP7v8xRoeRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549948; c=relaxed/simple;
	bh=XGl0H6G8dXCFNl+aZogBOyimc8nFpBCBsEW4D+H6Tiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEETwQ4lo+KOS5hWt65oBdTh+12LgPTHeeIF7QH+7Xqt2iqk8fQWTQ3glul4lmTYsv8VXrKXKdKxm95DrbYW1kSTYiX/KdWQ+eUcXp47bpKMJcxyo4KCtDu4NHUBHND+z06GsMPxQ7dZoZ0nKB46KdDfkpMAKSPEf4FqxbmqgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc7KCIjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc7KCIjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A38C43390;
	Mon, 29 Jan 2024 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706549947;
	bh=XGl0H6G8dXCFNl+aZogBOyimc8nFpBCBsEW4D+H6Tiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mc7KCIjMGFgm95sWgnaK/qt27d1UP5WZGpF0uBqy73petXYwvdd3BBy41NpiWc4GZ
	 N2di+8oB/tv9Bj7S4aLORso4h8huv7dU6ymgshHkemb0gyKPL9FKAXZRt9lYQkO+Yh
	 kA+XKtw+aE8LllRM4GurJM72Oo4pdHXomVcnnxzepkTN4GUXlOqPCqVok/rcV+rQmL
	 rVfqFAreyAjffRBmhk5S6Mcggjd2voc0YKlkcjiomCdx+TjaXXBSBV24wUDJPJ6otR
	 dVrS5JCeSw+8jcDcAui2vy8FYCfzTEzTEPphfV65DJBRwh1N1z5hK1KizHrvxFNkh4
	 YOtT8On56O89w==
Date: Mon, 29 Jan 2024 18:38:59 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: linux-sparse@vger.kernel.org
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
	Vladimir Petko <vladimir.petko@canonical.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Geliang Tang <geliang@kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/5] Support LLVM-15 and later
Message-ID: <olxwlte2utzht7xbmcti74t7hrjoxy6k4dywa5lyx6zt36mzgk@44tsqsejw33z>
References: <20240120005514.90873-1-lucvoo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120005514.90873-1-lucvoo@kernel.org>

On Sat, Jan 20, 2024 at 01:55:02AM +0100, lucvoo@kernel.org wrote:
> From: Luc Van Oostenryck <lucvoo@kernel.org>
> 
> With the introduction of opaque pointers in LLVM-15, some of the
> LLVM builder functions' signature have changed in order to add
> the now missing type information.
> 
> sparse-llvm still uses the old API and thus can't work with LLVM-15 and later.
> 
> This series, based on a previous patch by Vladimir Petko, not counting a few
> preparatory patches, contains 2 patches to:
> 	* suppressing the deprecated warnings issued with LLVM-14
> 	* conditionally use the old API with LLVM-15 or later.

Upstreamed now.

Best regards,
-- Luc
