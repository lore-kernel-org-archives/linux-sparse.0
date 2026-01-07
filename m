Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B133EAEA
	for <linux-sparse@vger.kernel.org>; Wed,  7 Jan 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814846; cv=none; b=j9Om//8i3zDDE+8Q2jGK0eR7d/yd8Z/mPiqa09qNp50QuxJNN2Z3wO0BluhXPrCMpsHXB06Nshzap30W9H9RDLzH/AXVGiABx7AOeUqvZMudRJ2UZXYc2nW2I9UTilX92J2b+7LId0lKont3AFcTOBZ3TJQh89l10a9Hi9V6D8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814846; c=relaxed/simple;
	bh=d5Exr3lNBq8nNf3duhI9J0nEWqRahWRTcbYnloplTdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBdXnooq5qSz8drCpRPqrPhGXMQK53YQv5Sc/dt5KQ9pAmXHlas4HoOCY15FFgqVXwpSpuk1fxlUWpwy2C8NIH91LuOnw08oUMlXjceA01vFjsAaZU6THLpEOU8947E2Emj22WF+62pycI/AU4W+lIN2Moi1MnWZW4yVSm62JNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sq+9X/Tv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sq+9X/Tv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc3056afso1310116f8f.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jan 2026 11:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767814836; x=1768419636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9qp/wBZU7XdNfMAKopP+CuoCoP4SMdYZKFTWPithHI=;
        b=sq+9X/Tv/PSy4XgqXq6aoEPBqEuC8nZaOvxNcqimCPU2ZYIWg7uhQ4tafPCZspoy+g
         xF6K7dnyQ6biCQYSopT/j/Mhzrpdkj3VHPSRaEAkB+sRGFHeghkTdND0GUiu5Bg12ZQl
         3pgJZO/byBTCPTGrNE1OkwIZjf5yiUESYBQKWvZO77oOZB83eeuIMLWTtX03M3zann6x
         kvNEmO/iJ5OMWvir/Aqd39Be6VOxQN8rZ1iWWP9tY3JoRUFZUlkdn0fbUUsyGyQqQkwt
         dxLrMC7+VeN6Nska7mgnc2JGTW6Lmu88cOeuNJV3DLg9E3U8/gsEwSMkgf8aFmK24xQZ
         uFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767814836; x=1768419636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9qp/wBZU7XdNfMAKopP+CuoCoP4SMdYZKFTWPithHI=;
        b=QnwrtDvnExory4vEER2UPFNnj4ZHUSEoSR/gv/D52fYuaK9RaH3+ZO6XQGp7RL+1JX
         B2wDUxop1IIzBa99bQE4PWqYWo5rtmTTD/HkHF/JK5oSni7uoX3nLX9Wp2yDumgwTiO6
         sLZYvnaoRbwwmDRT4P4vc1r18YLOKe3egDxBtD+go9p61HWCh+hrHeZiuTPSVBUinJ6B
         kjM2ITAXMo1/bG4DkQyVl4I262RmoPo6XxscFOS5on//Tmal7cn+c/O2NeQsbUz7irmp
         8EiOgxJx00s+BLcILm3dAuRsmzTbGh0WW6cgvuNBfexn9VlRewdRVV+ZzN4BusaAEXJN
         bHyg==
X-Gm-Message-State: AOJu0YwpHndeByAd6EaTiAhI6cVDUtfuXcea28kpI7f2t8EtSQcXpYAg
	C35NRGhXaOf4bdYFMPqQxMnxsSyqjbMq6IhDZGBdZa/1DHAoYS8pp2OImrD8tthAPz0=
X-Gm-Gg: AY/fxX7DasSCtJxF/AEXubcEs97ocS6Zp+uo7EUOmJ1cRTTBNBVjLjQHmzfBMq9G7Pb
	IKe9BqPF+lMDP8xlYA4jAg4vA598xjOYce/DCFumYRZzxXKo0zfrTPUXb6RnIYk40TN2hcgYMDw
	dqnzGjBQEjUtHceb6sVKDuHWNm3QvIm9Aggl8aKq6AL1fQaT5Fx6E4y6r791fToOB6OM5DI/jyL
	j/8ep25VpwAy5jIbcpWost34+8pvDSzU6GcwxcK2c780enQMK/g8C9WN1z23tpsP02k9GpGopi/
	GbVYdZ4hozpf1ZHxWvfJvQVna3fuCyyRBcYzTMdXx+GxLm0A+mVPG/BtqAxQtG4klHOeqUOyfKR
	aTD2KhreL4FSWIUfJkttUbsPBfjbDiyc0c2phZjgZtu4ZU3iXu618RSDhjpQE5xM9cyir5p1D2W
	IK+Aw29SXjppW2jzGs
X-Google-Smtp-Source: AGHT+IG9madqmCfzYhtzDDLi/77hzRiTa5xL6Kwsnf4g4n2X2klMUxtOB54dDHw6XuVwe0tXJG8NXQ==
X-Received: by 2002:adf:f609:0:b0:432:5bef:ecf7 with SMTP id ffacd0b85a97d-432c375b500mr3784377f8f.37.1767814835802;
        Wed, 07 Jan 2026 11:40:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm12725120f8f.41.2026.01.07.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 11:40:35 -0800 (PST)
Date: Wed, 7 Jan 2026 22:40:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org
Subject: Re: req: option to show area warning is from
Message-ID: <aV62sDxNla12F1V4@stanley.mountain>
References: <944a3c73-f971-441c-8ba6-344f1ac099f3@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <944a3c73-f971-441c-8ba6-344f1ac099f3@codethink.co.uk>

On Wed, Jan 07, 2026 at 02:58:44PM +0000, Ben Dooks wrote:
> I think it would be useful to have an option to show a more detailed
> view of which part of the source generated a warning. Would this be
> possible and if so is there anyone interested in doing it?
>=20
> I'm looking at the following warning:
> ./include/trace/events/xdp.h:304:1: warning: Using plain integer as NULL
> pointer
>=20
> And the kernel source from the pre-processed file looks like this:
>=20
> > static __attribute__((no_instrument_function)) void do_perf_trace_mem_d=
isconnect(void *__data, const struct xdp_mem_allocator *xa) { struct trace_=
event_call *event_call =3D __data; struct trace_event_data_offsets_mem_disc=
onnect __attribute__((__unused__)) __data_offsets; struct trace_event_raw_m=
em_disconnect *entry; struct pt_regs *__regs; u64 __count =3D 1; struct tas=
k_struct *__task =3D ((void *)0); struct hlist_head *head; int __entry_size=
; int __data_size; int rctx; __data_size =3D trace_event_get_offsets_mem_di=
sconnect(&__data_offsets, xa); head =3D ({ do { const void __seg_gs *__vpp_=
verify =3D (typeof((event_call->perf_events) + 0))((void *)0); (void)__vpp_=
verify; } while (0); ({ unsigned long tcp_ptr__ =3D ({ *( typeof(this_cpu_o=
ff) *)(&(this_cpu_off)); }); tcp_ptr__ +=3D ( unsigned long)(event_call->pe=
rf_events); (__typeof_unqual__(*(event_call->perf_events)) *)tcp_ptr__; });=
 }); if (!bpf_prog_array_valid(event_call) && __builtin_constant_p(!__task)=
 && !__task && hlist_empty(head)) return; __entry_size =3D ((((__data_size =
+ sizeof(*entry) + sizeof(u32))) + ((__typeof__((__data_size + sizeof(*entr=
y) + sizeof(u32))))((sizeof(u64))) - 1)) & ~((__typeof__((__data_size + siz=
eof(*entry) + sizeof(u32))))((sizeof(u64))) - 1)); __entry_size -=3D sizeof=
(u32); entry =3D perf_trace_buf_alloc(__entry_size, &__regs, &rctx); if (!e=
ntry) return; perf_fetch_caller_regs(__regs); { entry->xa =3D xa; entry->me=
m_id =3D xa->mem.id; entry->mem_type =3D xa->mem.type; entry->allocator =3D=
 xa->allocator;; } perf_trace_run_bpf_submit(entry, __entry_size, rctx, eve=
nt_call, __count, __regs, head, __task); } static __attribute__((no_instrum=
ent_function)) void perf_trace_mem_disconnect(void *__data, const struct xd=
p_mem_allocator *xa) { u64 __count __attribute__((unused)); struct task_str=
uct *__task __attribute__((unused)); do_perf_trace_mem_disconnect(__data, x=
a); }; static inline __attribute__((__gnu_inline__)) __attribute__((__unuse=
d__)) __attribute__((no_instrument_function)) void perf_test_probe_mem_disc=
onnect(void) { check_trace_callback_type_mem_disconnect(perf_trace_mem_disc=
onnect); };
>=20
>=20
> This is obviously a lot to go through and very difficult to read.
>=20
> It would be great if we could get a dump of what was going on.

Yeah, I spend a lot of time adding newlines to pre-processed code.  Is
there a good script to re-indent .i files?

regards,
dan carpenter
