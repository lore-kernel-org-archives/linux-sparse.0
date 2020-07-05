From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] sindex: avoid a warning with 'case -1:'
Date: Sun, 5 Jul 2020 13:12:04 +0200
Message-ID: <20200705111204.lqutcuzkjkb4unl7@comp-core-i7-2640m-0182e6>
References: <20200704235453.7756-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from raptor.unsafe.ru ([5.9.43.93]:60518 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELVx (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 07:21:53 -0400
Content-Disposition: inline
In-Reply-To: <20200704235453.7756-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jul 05, 2020 at 01:54:53AM +0200, Luc Van Oostenryck wrote:
> When parsing the format, there is a 'case -1:' which:
> * seems to be there only for the following label (but mixing
>   labels with cases, like here, is OK).
> * on architectures where chars are unsigned, the compiler complains:
> 	warning: case label value is less than minimum value for type
> 
> So, remove the unneeded 'case -1:' and use an explicit 'default:'
> to catch invalid formats. Also, align the label with the cases,
> it looks nicer so.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Looks good :)

Reviewed-by: Alexey Gladkov <gladkov.alexey@gmail.com>

> ---
>  sindex.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sindex.c b/sindex.c
> index ea092a4a434b..22836a957213 100644
> --- a/sindex.c
> +++ b/sindex.c
> @@ -970,8 +970,8 @@ static int search_query_callback(void *data, int argc, char **argv, char **colna
>  					print_file_line(argv[0], atoi(argv[1]));
>  					fmt++;
>  					break;
> -				case -1:
> -print_string:
> +
> +				print_string:
>  					if (n) {
>  						printf("%.*s", n, buf);
>  						n = 0;
> @@ -979,6 +979,9 @@ print_string:
>  					printf("%s", argv[colnum]);
>  					fmt++;
>  					break;
> +				default:
> +					break;
> +
>  			}
>  
>  			if (pos == fmt)
> -- 
> 2.27.0
> 

-- 
Rgrds, legion
