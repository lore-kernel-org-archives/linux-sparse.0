Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2932D6E63
	for <linux-sparse@vger.kernel.org>; Sat, 27 Dec 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851130; cv=none; b=Cesy3dSudPfkoPBvXau3aVpsD3H3JlQZ+8Lisyggk0Y6KFfeBsfeXC4qzmhd+SKLaU/HpcqEOUFiw0vzAbN8V3l7r3HXJ14t6LrKWRkp9i4lHl3U/kjrM47+MGwFcIypnCg0jFHVPF/6vDE8taU4GSxF568j6Um8G9gKpcPCXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851130; c=relaxed/simple;
	bh=rgMZYtMINKu/cu/GQcVVwt/EhyizAHjQJm98KbNG3BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPhkoe+Ro7IAl9I41WxiP5lSAX/oxPw48PTfA4fjb+RL6hGjudIbRbNL/7s65Cqn7pldKJhkkwv3Yio8cF7i3HIT/5BpdUJWBsgGhPR9Gvx/wQMdNOblh/Kso901VTPmWWIjgty1jefumGNK1J7bNU/enb9scOxJypgNZuKVx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ7umuT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ7umuT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB630C4CEF1;
	Sat, 27 Dec 2025 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766851129;
	bh=rgMZYtMINKu/cu/GQcVVwt/EhyizAHjQJm98KbNG3BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZ7umuT7wNvGWEw+xGSX7OASbjz8/0/TeFbWXbaAHVFbv7NkX1h6h1pAe26VvMd4I
	 KfZTA6W/8P6SXwJL58uqsNaDM88N0dcfdLHbJnmHp2tfg0pUkkZfo2hIcrC82PaYdr
	 nSIuZyDXEvi65fiCygQOvQWjgJGCLzW8azwcDxv+1H4zgTbswGjkoVyKNtQaYUxrtB
	 g/efsKor1Iru+jkeW444HWZyuQv4CWEVfHy7CfiBuOWrwTp115+DQebDQb31ZUVcLY
	 Wx1T1vv8YIgeDXgJnBWxfyQnwBHbVfYBZjHvGVVZyTs1HCAfrgGx1hUXL+JVHDuYqd
	 EuprQwEbbHa6w==
Date: Sat, 27 Dec 2025 16:58:45 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <lucvoo@kernel.org>,
	linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/2] sparse/semind: add the new
 --param=dissect-show-compiled option
Message-ID: <aVACNT1JYz4u3X7h@example.org>
References: <aU6cXFyfwtD9GMYa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU6cXFyfwtD9GMYa@redhat.com>

On Fri, Dec 26, 2025 at 03:31:56PM +0100, Oleg Nesterov wrote:
> parse_cmdline_add() sets dissect_show_all_symbols = 1 unconditionally
> and currently it is not possible to clear this option.
> 
> We could simply remove this line; users could use
> "semind add --param=dissect-show-all-symbols," but this would break
> existing setups.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  options.c | 2 ++
>  semind.c  | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/options.c b/options.c
> index 0f207e80..dbe0349f 100644
> --- a/options.c
> +++ b/options.c
> @@ -976,6 +976,8 @@ static char **handle_param(char *arg, char **next)
>  
>  	if (!strcmp(value, "dissect-show-all-symbols"))
>  		dissect_show_all_symbols = 1;
> +	else if (!strcmp(value, "dissect-show-compiled"))
> +		dissect_show_all_symbols = 0;
>  
>  	return next;
>  }
> diff --git a/semind.c b/semind.c
> index ad8003ba..fa084e04 100644
> --- a/semind.c
> +++ b/semind.c
> @@ -322,14 +322,14 @@ done:
>  		show_usage();
>  	}
>  
> -	// enforce tabstop
> +	// enforce defaults
>  	tabstop = 1;
> +	dissect_show_all_symbols = 1;
>  
>  	// step back since sparse_initialize will ignore argv[0].
>  	optind--;
>  
>  	sparse_initialize(argc - optind, argv + optind, &semind_filelist);
> -	dissect_show_all_symbols = 1;
>  }
>  
>  static void parse_cmdline_rm(int argc, char **argv)
> -- 
> 2.52.0
> 
> 

-- 
Rgrds, legion

