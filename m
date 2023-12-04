Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKFe5TCk"
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637AFE5
	for <linux-sparse@vger.kernel.org>; Mon,  4 Dec 2023 06:37:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a18b478e4e9so572690666b.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Dec 2023 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701700660; x=1702305460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cfn7uGwcKAUkgRTp+ExUpRB7/0MVYEThvvklCieIDDo=;
        b=aKFe5TCketCRlYUHp7ERd6FOVAusMqipg3ertybVmDyC2EIbSO3T+Yh8ahlP540BPj
         KhrdodXi7b6EV842lcMFh5OvUgb36F1p6j2BWq6AqDD3p/0sB/B74ZnBPLSPOYSFDdkX
         UhX7BvQv4YD75gxa0Vr7otS5FG2SYinedzgWQBsiABBWEGRmm8vyJwKQuDhUvimy3Gt9
         ASLQ0ZzE/pzcgSuvmHZ1nMEHMy8ITxI2/HYec+/L/0V2A1QQdX9bSQ+p2X9ubEoiarhu
         EH1CXtF1Z1QknoIYffCtbycyqjiGksq95Wvcau2lrcL7YQh2JZ/s3Z/T5nVcLv1SpHbv
         lIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701700660; x=1702305460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfn7uGwcKAUkgRTp+ExUpRB7/0MVYEThvvklCieIDDo=;
        b=GjIn1BeGuVEF2SBkagEz34FbwWtG+1mAMQqFAC94yqpCuyKvnkwVehZ4KiVX+PBvS8
         OyNF4YPyDXdy/X8ngmTpB/Gw+hKxcxIaWK7uOVu1DuRcfZU7+m9hlQAOthVWz7gz5nF9
         ChjV7o2AHRBIGEGsJqFHsm8S9+HN4+Oe30fhHwryIXuqP2Dp86zQmUpui7YPi4N2rrmZ
         lozDYV7TTe82cBhX3L/KT6739aGpCHI9WIe5begatSEjmaarN1Xks9UDLhcxLc2A2dhK
         lRvA8HMu+Utpd0FgxEGq8y/s0KqoM5REr95xTWBu8ynayIX7hguneeLXA4rc8R4pEYBT
         Dw+g==
X-Gm-Message-State: AOJu0Ywlzay+ilFL+1q6oZZa777DHfKccCv7l8xH2BPm+dfM4EleEQew
	NWHW1oYrQAbzY9j3iGSy2b8=
X-Google-Smtp-Source: AGHT+IF41drT06evFT1JZs21RlwAR93OUMjCnoX6kPnE40CzEl24ptL5ZtoHcYaV9/jwz6G3V1J6yg==
X-Received: by 2002:a17:906:dfe9:b0:a19:1bba:d4c with SMTP id lc9-20020a170906dfe900b00a191bba0d4cmr3360307ejc.16.1701700659574;
        Mon, 04 Dec 2023 06:37:39 -0800 (PST)
Received: from mail ([87.66.46.106])
        by smtp.gmail.com with ESMTPSA id vg17-20020a170907d31100b00a1aa6f2d5fcsm2753424ejc.110.2023.12.04.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:37:38 -0800 (PST)
Date: Mon, 4 Dec 2023 15:37:37 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
Message-ID: <oz64jus6uqtwj76jvc5imywhwnrur4s6vuvcg3lntpj4s7dqna@fd4pecivhf2u>
References: <202310080853.UhMe5iWa-lkp@intel.com>
 <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
 <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
 <CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS6PQd1Bec-2NicUiwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS6PQd1Bec-2NicUiwQ@mail.gmail.com>

On Mon, Dec 04, 2023 at 02:57:53PM +0100, Uros Bizjak wrote:
> On Mon, Dec 4, 2023 at 2:05 PM Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> 
> __seg_gs qualified variables can be referenced anywhere in the code, e.g.:
> 
> --cut here--
> __seg_gs int m;
> 
> int foo (void)
> {
>  return m + m;
> }

Yes, of course. But my point was not if they *can* be dereferenced but rather
if *in the kernel, do want or not to use 'naked' __seg_gs qualified variable*.
In other words, do we want to be warned if someone, somewhere try to
dereference such qualified variable without using the accessor function?
And I think the answer to this question should be 'yes'.

-- Luc
