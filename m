Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37A495C1
	for <linux-sparse@vger.kernel.org>; Wed, 27 Dec 2023 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4SnEYgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F3C433C7;
	Wed, 27 Dec 2023 23:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703720773;
	bh=Mx3V2yujE8AO3ADhLKFw1S/QT11S5mku/7qbfna29aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4SnEYgVJ9nIfEM0xp953lMPS9H4GhuZcwhJQZk05fazfKd/Bz/DBuk14EGUhu2xY
	 DluRINlD+pym10HYSKBSPSPgwOdI6ALySoDFdO33aBcLpD+8qdtn74gZdIFNzBmuXr
	 4YqZEo8ALiXu70WPp3l3U9acC3lpeCw5ieBGz7UENpAYcWcFDSvQVKtU36CkdONrOC
	 rY2h6tKid76lEKGyOFbNH/OW1j5j8M2l4wGQb7aemvRzxjFyck4chYI4Z3fPTm+xf3
	 60RH7zouIZXHZtrLlT674haMOq1EoolZOqxWhAjf2GuXmLYBdAdv9nawUBFIwSlWAv
	 YBxw1FHKCCAvw==
Date: Thu, 28 Dec 2023 00:46:04 +0100
From: Luc Van Oostenryck <lucvoo@kernel.org>
To: "Herbert, Marc" <marc.herbert@intel.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Re: Infinite loop in delete_pseudo_user_list_entry() bisected to
 commit "cast: optimize away casts to/from pointers"
Message-ID: <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>

On Wed, Dec 27, 2023 at 08:00:32AM +0000, Herbert, Marc wrote:
> Hi,
> 
>  I just bisected and gathered detailed information about a 100%-reproducible infinite loop in simplify.c:delete_pseudo_user_list_entry().
> 
> If you're interested please take a look at https://github.com/zephyrproject-rtos/zephyr/issues/63417#issuecomment-1870029877
> 
> Marc

Hi,

I've some problems to reproduce this.
Would it be possible to get the result of the preprocessing of the file tls.c ?
For example get the exact sparse command, something like:
	sparse ... arch/arm64/core/tls.c
and the changing it by:
	sparse ... arch/arm64/core/tls.c -E > tls.i

Best regards,
-- Luc
