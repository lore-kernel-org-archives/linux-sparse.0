Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A32C321
	for <linux-sparse@vger.kernel.org>; Mon,  1 Dec 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602627; cv=none; b=IHlxcoTSZWzc/xytkNKCSuX4AqKPe2bb4h1DU05X31M3e+JOhTdQt6ygZPcw/RmdfdjgXm1rlIlD1q8IUaZ+fIMkjcNEi2oxT24MsOfYmuDXi2Lnl5S8j0G9qS2hPlP85iBArVieyTWO0g88mhmrps0d0ACk6PDyIXNgfTsqvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602627; c=relaxed/simple;
	bh=fTX1cx0FM8NGo7IlEXlG3DHrys+Iu+Xt/cdcQSiEKC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3qgOt1I5mWK95DIRx9ZqngrdUsvXe+nTfmgLzSYE9cBB2FO9KYSTUf0TfP4FdiHqIlfKnar6+WJjrRS45gMmcM92wGkBJLQSJStpuF5AFdJG0qqYHHapGISLhEfD43m1MpahRMem7H0CP/G0bci53eTM51VwRWSSA0D++amzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-789524e6719so61086147b3.1
        for <linux-sparse@vger.kernel.org>; Mon, 01 Dec 2025 07:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764602624; x=1765207424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tZi8Fu+1zhQCrs/QAIDe3qgemSjnFik6PMQEoytThY=;
        b=Bw0261zzT6HupOTrYE/jFvHbvaJT8anwUsAEZZlun3GqVd59kVdI34xjmd6l4AVtRR
         XjfC/qvOMniCyQuwmhuvlIwGpcsURlbyLbJ8vqlI4pjeOO80lC9ysDd0QfykjjLQ2QfA
         +QGJ4Hxud+APfok+ATRVBHchbMxyCx2+qNDrfnojQg0nTq+7smHlIIBwG+c9NqbOlI6a
         ZuI/NhB79y60IKwSLVaP/Pnqt1fObKwxahySgaGI55WF0fBG8uaKePSlJX+Kt8SPuGF5
         MP3O6dNefbvbjEN5gJsRIDSCks0Dpu837l/RZcLP+zxFnsZuN7bi/E0YnT9oBEOGQpMN
         Bp/g==
X-Forwarded-Encrypted: i=1; AJvYcCWDmLTqAh1mIZF2grBqW5bEdDSRbynX2W7q9GR1VW3WMgjCMf9J6kFpMwZ+3Iq4ahccT8WQBmhHoSYargo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0o1TYrzboC0OaLSJBUL4vVz6CNg4q5kS5wFly0wdDUWZUhTS
	91NCKpGdV/usAGCFWHLHDZpiaLWaD6Eyb6ClndPNF8GH2kEwQQvuZxSLLb0PRfrQ/vGLab2wSKP
	4Z0MRIypeYnVbMDjdkoRH4/BLusr7ovANeF98z6TsEA==
X-Gm-Gg: ASbGncvsdd7TUuK+on1LLLlVwY8GWmoFcINtWOG/lOH1Fc9zNfBRg5fF3zorrV1nizL
	337TBDzaOpGV3hDTKW/czC38zG8+AA+kWM7BsX7kqHt+Rj93WFktZxrAh+Z4///J/gjV7MoSTM4
	pDiLfJdbG4Gn7rCeEHrkl82EmfVbZE81BPz1EpsIZdC+caaC6cfIXveUjmIhRepFSeJNnPvxUKi
	2eXuTXyn9CnQTpsftF+XVGeJF0ComVa7ISYn76QJq2fMPHdbJ4a6ceYJzduNyV7JDWd7sH9RMJm
	sPx/pH9awq+fhAtqkV+/U40vA5Ip
X-Google-Smtp-Source: AGHT+IHfZDMO30awYc7JxY5dnUGX9leAX8W0Kypoo19Pf5KDZnq9OcL94r6xlIINv0iT7m8kxVpti8Jk09Uq/KJsb+Q=
X-Received: by 2002:a05:690e:c41:b0:640:db57:8d93 with SMTP id
 956f58d0204a3-642f8dee6bemr30441851d50.15.1764602624048; Mon, 01 Dec 2025
 07:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQC_tw-8gLpf00yH@stanley.mountain>
In-Reply-To: <aQC_tw-8gLpf00yH@stanley.mountain>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 1 Dec 2025 19:23:32 +0400
X-Gm-Features: AWmQ_bkoEizAHKNC6ZYu0fqLhp2Y07MDS3NAH7_3c9EvqDDmtTF8NorK3rySK0s
Message-ID: <CACePvbWmmOED+5bAKT5SfA1c0YqN2v-wEEim6X-uHT8H-qaGHg@mail.gmail.com>
Subject: Re: [PATCH v2] symbol: preserve address space qualifiers with typeof()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for the patch. Sorry for the late reply. Super busy recently.
Now I am back and catching up on my back logs.

On Tue, Oct 28, 2025 at 5:06=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> When we're parsing typeof(var) we then preserve the address space
> qualifiers as well.  Otherwise it leads to warnings like this:
>
> "warning: cast removes address space '__seg_gs' of expression"
>
> Reported-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Your patch makes one of the known to fail tests passed. I took the
liberty to add the following change to make validation check happy:
diff --git a/validation/typeof-addresspace.c b/validation/typeof-addresspac=
e.c
index a94f77a3..34ac3089 100644
--- a/validation/typeof-addresspace.c
+++ b/validation/typeof-addresspace.c
@@ -16,5 +16,4 @@ static void test_as(void)

 /*
  * check-name: typeof-addresspace.c
- * check-known-to-fail
  */

Applied to sparse-dev.

Chris

> ---
> v2: Fix a NULL dereference because "base" can be NULL.  Sorry for not
> running the validation/ tests...  :(
>
>  symbol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/symbol.c b/symbol.c
> index 7060acb666d9..a42289226650 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -544,9 +544,12 @@ static struct symbol *examine_pointer_type(struct sy=
mbol *sym)
>  static struct symbol *examine_typeof_helper(struct symbol *sym, bool qua=
l)
>  {
>         struct symbol *base =3D evaluate_expression(sym->initializer);
> +       struct ident *as =3D NULL;
>         unsigned long mod =3D 0;
>
> -       if (!base)
> +       if (base)
> +               as =3D base->ctype.as;
> +       else
>                 base =3D &bad_ctype;
>         if (base->type =3D=3D SYM_NODE) {
>                 mod |=3D base->ctype.modifiers & MOD_TYPEOF;
> @@ -559,6 +562,8 @@ static struct symbol *examine_typeof_helper(struct sy=
mbol *sym, bool qual)
>         sym->type =3D SYM_NODE;
>         sym->ctype.modifiers =3D mod;
>         sym->ctype.base_type =3D base;
> +       if (qual)
> +               sym->ctype.as =3D as;
>         return examine_node_type(sym);
>  }
>
> --
> 2.51.0
>
