From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 3/3 V2] lib.c: add Wall_off switch
Date: Fri, 31 Jul 2015 14:01:43 -0400
Message-ID: <55BBB807.2040807@redhat.com>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <1438362734-14505-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbbGaSBo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Jul 2015 14:01:44 -0400
In-Reply-To: <1438362734-14505-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org, linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

On 07/31/2015 01:12 PM, Tony Camuso wrote:
> Disables all warning and error reporting for using sparse as a
> tokenizer only.
>
> Signed-off-by: Tony Camuso <tcamuso@redhat.com>

Spoke too soon ..

NAK

I'll send an update when I have something that really works.

> ---
>   lib.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/lib.c b/lib.c
> index 8dc5bcf..c274a68 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -241,6 +241,7 @@ int Wtypesign = 0;
>   int Wundef = 0;
>   int Wuninitialized = 1;
>   int Wvla = 1;
> +int Wall_off = 0;
>
>   int dbg_entry = 0;
>   int dbg_dead = 0;
> @@ -464,6 +465,7 @@ static const struct warning {
>   	{ "undef", &Wundef },
>   	{ "uninitialized", &Wuninitialized },
>   	{ "vla", &Wvla },
> +	{ "all_off", &Wall_off },
>   };
>
>   enum {
> @@ -479,6 +481,12 @@ static char **handle_onoff_switch(char *arg, char **next, const struct warning w
>   	char *p = arg + 1;
>   	unsigned i;
>
> +	if (!strcmp(p, "all_off")) {
> +		for (i = 0; i < n; i++)
> +			*warnings[i].flag = WARNING_FORCE_OFF;
> +		return NULL;
> +	}
> +
>   	if (!strcmp(p, "sparse-all")) {
>   		for (i = 0; i < n; i++) {
>   			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
>

