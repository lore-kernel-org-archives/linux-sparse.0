Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaDPXnZp"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885FA7
	for <linux-sparse@vger.kernel.org>; Mon,  4 Dec 2023 05:05:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so5010832a12.0
        for <linux-sparse@vger.kernel.org>; Mon, 04 Dec 2023 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701695128; x=1702299928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VA51eSka7DjkZsQY1gIxjbQlwGTEw5veLP3tiH1HmE=;
        b=YaDPXnZpJFG7jvFeWNrIj6rzvyOajyPs5A2oHwZXH4AA5CVNIRHW8H6ODdO5aH/dbw
         42lJmDVXnP3Y5ODF2s5toKNvImftbPjTa2gM/4q5YD6t5+4jImuNEZK961+YpVbeuYRJ
         rkSMv9bcvvtY3UdkLF0ISzz4vc4f3/QHJQXW/4YvYXxd/ebyGll4y0LX8exjJGFHaf2f
         O8Zg/d9CMCyQoXNRcrxx97eeuZrO2xMNjte79oV9Yyrk+kmRjRzljx0QsR3ybP3+6GRS
         u3YLtlH5ZL2VPpc3fpbctrvWYD5hr0sa0AdNyotbLB/Iyb6wIKUVbRbHELPLOscOR5PP
         pN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695128; x=1702299928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VA51eSka7DjkZsQY1gIxjbQlwGTEw5veLP3tiH1HmE=;
        b=LwjWns2i8q9RoolTx2DmM0fnrMdeKJDL0JDiYodkgGiZgR7qV9mWQHIXCmkEg/ZwY+
         d6cn1cBVqWzLTB3M8htx32NPn+BW+2JlQQEw/p0IbnZUsGBTT7rZZb38xnxP1okCAoup
         eRCU43d9aprTmHqPnPiAZdNXitzR8BUjlcUCsZmMo7xD00YTGT1ugMeZVgjrK1n+KLVR
         nDTxbeSBNFaAoteTxyDZlzXWSg6tjvlOneedUru/bkVIIciwaQ/zYpC2+bdRBD8f4lLO
         Bsiry5FgD7C52vsGsBfHlF9xdeEzOkenLMDCpVBLe8/I3AYRdyqIrFIbXensHvvWIQzp
         wK0w==
X-Gm-Message-State: AOJu0YwJGJUi6MIhbIHf5ALn4QDgGydGsLFPD6j0k8fHrMGvWtitN54d
	n38s9UsQjNipaPwJGUbMWef7YF2ET06z3Q==
X-Google-Smtp-Source: AGHT+IHRDepQqFrS1OuAQZyJvPqoC7hy4NoYFp1CYzo8FxrsO1SjVArchFI1h0339eOkbHMyS8fyyg==
X-Received: by 2002:a50:c251:0:b0:54c:c745:49e2 with SMTP id t17-20020a50c251000000b0054cc74549e2mr458100edf.140.1701695127596;
        Mon, 04 Dec 2023 05:05:27 -0800 (PST)
Received: from mail ([87.66.46.106])
        by smtp.gmail.com with ESMTPSA id s19-20020a05640217d300b0054ca2619c1bsm2153178edy.9.2023.12.04.05.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:05:26 -0800 (PST)
Date: Mon, 4 Dec 2023 14:05:25 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
Message-ID: <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
References: <202310080853.UhMe5iWa-lkp@intel.com>
 <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com>

On Fri, Dec 01, 2023 at 03:10:35PM +0100, Uros Bizjak wrote:
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/bpf/percpu_freelist.c: note: in included file (through arch/x86/include/asm/preempt.h, include/linux/preempt.h, include/linux/spinlock.h, ...):
> >    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: Expected ) at end of cast operator
> >    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: got __seg_gs
> >    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: Expected ) at end of cast operator
> >    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: got __seg_gs
> 
> sparse is too strict here. The following code is perfectly legal:
> 

It's not that sparse is too strict, it's because it knows nothing about __seg_gs.

What is missing is:
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 547ea1ff806e..9214f6d54e63 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -23,6 +23,7 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
+# define __seg_gs	__attribute__((noderef, address_space(__seg_gs)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* context/locking */


But with this patch sparse will now complain with 'warning: dereference of noderef expression'
which are quite legit given the noderef and the way __seg_gs is used.
You have two choices quiet these:
1) If variables qualified with __seg_gs should only be dereferenced via some
   special accessor like __raw_cpu_{read,write}() the patch here above is
   correct and you need to fix the typing inside these accessors (using __force or
   casting to unsigned long like already done anyway in __my_cpu_ptr()).
   I think this is the correct solution.
2) If it's OK to dereference __seg_gs qualified variables anywhere in the code
   (I don't think we should), then the 'noderef' in the patch should be removed.

Sorry, I can't currently do any testing or so.
Best regards
 -- Luc
