Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn5a/gm4"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184D83
	for <linux-sparse@vger.kernel.org>; Mon,  4 Dec 2023 05:58:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50abb83866bso5785711e87.3
        for <linux-sparse@vger.kernel.org>; Mon, 04 Dec 2023 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701698285; x=1702303085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNQt+lsipdzna6DcAQ7xi7a6gBNht3wCxMbG5gbf+0Q=;
        b=Xn5a/gm4S388qTBGmH35nNYqOGwyAklxlD9osLizesuXrYtLY/nIglfP3Whzv/Lbyi
         mFRYea7B4DLEjxQ4kpkpoc+Fa9LHUjk6r+mrDkhlIldTE8YYfJyhkoudgo+4mr3sj4S3
         rwpZP7E7YN0cZAbu/g/RlHiYvBdJUwJWq6Q97tENFlhhb75UqYHFGAfZmp1GQ50/DaUQ
         NS1K/LkjsZIDDYir1RqCG3OzBvi/KTLEoJzSpL/65qfBblFSQm4MAXRTiUQdBDBHEGiX
         vm/kdb72xn3J7bQYGGGs2lrQTKliDdXMSkEWYOmCga0VUwI2KUKOfku9TRIRrezLQ+V0
         Th9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698285; x=1702303085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNQt+lsipdzna6DcAQ7xi7a6gBNht3wCxMbG5gbf+0Q=;
        b=go5Iygzuhhdb9drYsKCtLuTFSw2fFYt5UCL74hX9cRmezj/icxXn1SwvX/JU5za/34
         WSBFUGanzbAcmI+Iq5IxS2UMRtulY8/Z+4HU12MjD1+tbUD0kE435wrqXQvONPDIqZbR
         IkWPeUr26s7zep23gVcJzg4LcR81EHYCPkg0ttUW1Xz3hAeqJ1cZDGCnJwuxEBBwvR9b
         pTEYlb6Oy8/d64X5Y1ePFJ4VqhwEGdsNw4oBLjOC0U311ZlarxXcugvx1Vlez0Ctf3Jf
         MDzAuYpwP6Oxa5qhUMD00ifgP1o4VE5sKk4Otbn0Ncpaiyg4X2LRN3Zw0s9M4f4jSzBp
         kwCA==
X-Gm-Message-State: AOJu0Yxo7Rv5PYNwZeT+R1xANOnZyXRMKQubUP5qfhx+dW1/nQBRVRNJ
	uU/irna1jbKgdB4g1/OCJxfoXHMSKC6bhGTIKw0=
X-Google-Smtp-Source: AGHT+IEYyJ3NOLhwAH08hVoktkSOSahpBhocpwLDf9vY8Exf4SpjzdCYJXT+CyhTRGOWcO2HUaPXgehKTrkVcj2vIT8=
X-Received: by 2002:ac2:488c:0:b0:50b:f82d:7ffc with SMTP id
 x12-20020ac2488c000000b0050bf82d7ffcmr510679lfc.20.1701698285300; Mon, 04 Dec
 2023 05:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202310080853.UhMe5iWa-lkp@intel.com> <CAFULd4ZgT1dZFz36ZbPeqJa+U2NwusSTudg175sSarhpvEu-Zw@mail.gmail.com>
 <CAFULd4Zm94W07Rv+0J0E2=dtd3hoc7us_sQi-pOUiomYS1Za-w@mail.gmail.com> <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
In-Reply-To: <v3beizdy56kqr4jv4zhmy6slriifuqcqll2eucqykqjilxfdya@s5v5jaflavwh>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 4 Dec 2023 14:57:53 +0100
Message-ID: <CAFULd4YMcHhkSR4P5tq3ghLQyUCkiTOKS6PQd1Bec-2NicUiwQ@mail.gmail.com>
Subject: Re: sparse: Expected ) at end of cast operator, got __seg_gs
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000d01b16060baf8154"

--000000000000d01b16060baf8154
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 2:05=E2=80=AFPM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Dec 01, 2023 at 03:10:35PM +0100, Uros Bizjak wrote:
> > > sparse warnings: (new ones prefixed by >>)
> > >    kernel/bpf/percpu_freelist.c: note: in included file (through arch=
/x86/include/asm/preempt.h, include/linux/preempt.h, include/linux/spinlock=
.h, ...):
> > >    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: Expected ) a=
t end of cast operator
> > >    arch/x86/include/asm/percpu.h:550:49: sparse: sparse: got __seg_gs
> > >    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: Expected ) a=
t end of cast operator
> > >    arch/x86/include/asm/percpu.h:564:33: sparse: sparse: got __seg_gs
> >
> > sparse is too strict here. The following code is perfectly legal:
> >
>
> It's not that sparse is too strict, it's because it knows nothing about _=
_seg_gs.
>
> What is missing is:
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index 547ea1ff806e..9214f6d54e63 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -23,6 +23,7 @@
>  # define __iomem       __attribute__((noderef, address_space(__iomem)))
>  # define __percpu      __attribute__((noderef, address_space(__percpu)))
>  # define __rcu         __attribute__((noderef, address_space(__rcu)))
> +# define __seg_gs      __attribute__((noderef, address_space(__seg_gs)))
>  static inline void __chk_user_ptr(const volatile void __user *ptr) { }
>  static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  /* context/locking */
>
>
> But with this patch sparse will now complain with 'warning: dereference o=
f noderef expression'
> which are quite legit given the noderef and the way __seg_gs is used.
> You have two choices quiet these:
> 1) If variables qualified with __seg_gs should only be dereferenced via s=
ome
>    special accessor like __raw_cpu_{read,write}() the patch here above is
>    correct and you need to fix the typing inside these accessors (using _=
_force or
>    casting to unsigned long like already done anyway in __my_cpu_ptr()).
>    I think this is the correct solution.
> 2) If it's OK to dereference __seg_gs qualified variables anywhere in the=
 code
>    (I don't think we should), then the 'noderef' in the patch should be r=
emoved.

__seg_gs qualified variables can be referenced anywhere in the code, e.g.:

--cut here--
__seg_gs int m;

int foo (void)
{
 return m + m;
}
--cut here--

so option 2) should be the correct option here.

These __seg_gs and __seg_fs qualifiers are specific to x86, so I'd put
the definitions in the x86 specific percpu header, as in the attached
patch. The patch solves the reported issue.

Thanks,
Uros.

--000000000000d01b16060baf8154
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lpqz6x0k0>
X-Attachment-Id: f_lpqz6x0k0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggMGYxMmIyMDA0Yjk0Li4zMGU4MjNmNWFiNTUgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC05NSw2ICs5NSwxMSBAQAogCiAjZW5kaWYgLyogQ09ORklHX1NN
UCAqLwogCisjaWZkZWYgX19DSEVDS0VSX18KKyNkZWZpbmUgX19zZWdfZ3MJCV9fYXR0cmlidXRl
X18oKGFkZHJlc3Nfc3BhY2UoX19zZWdfZ3MpKSkKKyNkZWZpbmUgX19zZWdfZnMJCV9fYXR0cmli
dXRlX18oKGFkZHJlc3Nfc3BhY2UoX19zZWdfZnMpKSkKKyNlbmRpZgorCiAjZGVmaW5lIF9fbXlf
Y3B1X3R5cGUodmFyKQl0eXBlb2YodmFyKSBfX3BlcmNwdV9zZWdfb3ZlcnJpZGUKICNkZWZpbmUg
X19teV9jcHVfcHRyKHB0cikJKF9fbXlfY3B1X3R5cGUoKnB0cikgKikodWludHB0cl90KShwdHIp
CiAjZGVmaW5lIF9fbXlfY3B1X3Zhcih2YXIpCSgqX19teV9jcHVfcHRyKCZ2YXIpKQo=
--000000000000d01b16060baf8154--
